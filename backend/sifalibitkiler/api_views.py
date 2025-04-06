from rest_framework import viewsets, permissions, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import Q
from django.contrib.auth.models import User
from .models import Bitki, Rahatsizlik
from .serializers import (
    UserSerializer, RahatsizlikSerializer, 
    BitkiListSerializer, BitkiDetailSerializer, BitkiCreateUpdateSerializer
)

class UserViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Kullanıcıları listeleme ve görüntüleme için API endpoint'i
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

class RahatsizlikViewSet(viewsets.ModelViewSet):
    """
    Rahatsızlıklar için API endpoint'i
    """
    queryset = Rahatsizlik.objects.all()
    serializer_class = RahatsizlikSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['seviye', 'yayginlik']
    search_fields = ['isim', 'aciklama', 'belirtiler', 'etiketler']
    ordering_fields = ['isim', 'olusturulma_tarihi', 'guncellenme_tarihi']
    
    @action(detail=False, methods=['get'])
    def etiketler(self, request):
        """Tüm rahatsızlık etiketlerini döndürür"""
        etiketler_set = set()
        for rahatsizlik in Rahatsizlik.objects.all():
            etiketler_set.update(rahatsizlik.get_etiketler_list())
        
        return Response(sorted(list(etiketler_set)))

class BitkiViewSet(viewsets.ModelViewSet):
    """
    Bitkiler için API endpoint'i
    """
    queryset = Bitki.objects.all().prefetch_related('rahatsizliklar')
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['tip']
    search_fields = ['isim', 'faydalar', 'kullanim', 'bilimsel_ad', 'etiketler']
    ordering_fields = ['isim', 'olusturulma_tarihi', 'guncellenme_tarihi']
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    
    def get_serializer_class(self):
        if self.action == 'list':
            return BitkiListSerializer
        elif self.action in ['create', 'update', 'partial_update']:
            return BitkiCreateUpdateSerializer
        return BitkiDetailSerializer
    
    def get_queryset(self):
        queryset = super().get_queryset()
        
        # Mevsim filtresi
        mevsim = self.request.query_params.get('mevsim', None)
        if mevsim:
            queryset = queryset.filter(mevsim__icontains=mevsim)
        
        # Rahatsızlık filtresi
        rahatsizlik_id = self.request.query_params.get('rahatsizlik', None)
        if rahatsizlik_id:
            queryset = queryset.filter(rahatsizliklar__id=rahatsizlik_id)
        
        # Etiket filtresi
        etiket = self.request.query_params.get('etiket', None)
        if etiket:
            queryset = queryset.filter(etiketler__icontains=etiket)
        
        return queryset
    
    @action(detail=False, methods=['get'])
    def etiketler(self, request):
        """Tüm bitki etiketlerini döndürür"""
        etiketler_set = set()
        for bitki in Bitki.objects.all():
            etiketler_set.update(bitki.get_etiketler_list())
        
        return Response(sorted(list(etiketler_set)))
    
    @action(detail=False, methods=['get'])
    def mevsimler(self, request):
        """Tüm mevsim değerlerini döndürür"""
        mevsimler_set = set()
        for bitki in Bitki.objects.all():
            mevsimler_set.update(bitki.get_mevsim_list())
        
        return Response(sorted(list(mevsimler_set)))

    @action(detail=False, methods=['get'])
    def ara(self, request):
        """
        Gelişmiş arama işlevi
        ?q=<arama_terimi>&tip=<tip>&rahatsizlik=<rahatsizlik_id>
        """
        query = request.query_params.get('q', '')
        
        if not query:
            return Response(
                {'hata': 'Arama terimi gerekli'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        queryset = self.get_queryset().filter(
            Q(isim__icontains=query) | 
            Q(faydalar__icontains=query) |
            Q(kullanim__icontains=query) |
            Q(bilimsel_ad__icontains=query) |
            Q(etiketler__icontains=query)
        ).distinct()
        
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = BitkiListSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)
        
        serializer = BitkiListSerializer(queryset, many=True)
        return Response(serializer.data) 