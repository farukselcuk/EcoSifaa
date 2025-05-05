from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from sifalibitkiler.application.services import BitkiService, RahatsizlikService
from sifalibitkiler.infrastructure.repositories import DjangoBitkiRepository, DjangoRahatsizlikRepository
from sifalibitkiler.domain.entities import Bitki, Rahatsizlik

class BitkiViewSet(viewsets.ViewSet):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.bitki_service = BitkiService(DjangoBitkiRepository())

    def list(self, request):
        bitkiler = self.bitki_service.get_all_bitkiler()
        return Response([bitki.__dict__ for bitki in bitkiler])

    def retrieve(self, request, pk=None):
        bitki = self.bitki_service.get_bitki(int(pk))
        if bitki:
            return Response(bitki.__dict__)
        return Response(status=status.HTTP_404_NOT_FOUND)

    def create(self, request):
        bitki = Bitki(**request.data)
        created_bitki = self.bitki_service.create_bitki(bitki)
        return Response(created_bitki.__dict__, status=status.HTTP_201_CREATED)

    def update(self, request, pk=None):
        bitki = Bitki(**request.data)
        bitki.id = int(pk)
        updated_bitki = self.bitki_service.update_bitki(bitki)
        return Response(updated_bitki.__dict__)

    def destroy(self, request, pk=None):
        if self.bitki_service.delete_bitki(int(pk)):
            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response(status=status.HTTP_404_NOT_FOUND)

    @action(detail=False, methods=['get'])
    def search(self, request):
        name = request.query_params.get('name', '')
        bitkiler = self.bitki_service.search_bitkiler(name)
        return Response([bitki.__dict__ for bitki in bitkiler])

    @action(detail=True, methods=['get'])
    def rahatsizliklar(self, request, pk=None):
        bitkiler = self.bitki_service.get_bitkiler_by_rahatsizlik(int(pk))
        return Response([bitki.__dict__ for bitki in bitkiler])

class RahatsizlikViewSet(viewsets.ViewSet):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.rahatsizlik_service = RahatsizlikService(DjangoRahatsizlikRepository())

    def list(self, request):
        rahatsizliklar = self.rahatsizlik_service.get_all_rahatsizliklar()
        return Response([rahatsizlik.__dict__ for rahatsizlik in rahatsizliklar])

    def retrieve(self, request, pk=None):
        rahatsizlik = self.rahatsizlik_service.get_rahatsizlik(int(pk))
        if rahatsizlik:
            return Response(rahatsizlik.__dict__)
        return Response(status=status.HTTP_404_NOT_FOUND)

    def create(self, request):
        rahatsizlik = Rahatsizlik(**request.data)
        created_rahatsizlik = self.rahatsizlik_service.create_rahatsizlik(rahatsizlik)
        return Response(created_rahatsizlik.__dict__, status=status.HTTP_201_CREATED)

    def update(self, request, pk=None):
        rahatsizlik = Rahatsizlik(**request.data)
        rahatsizlik.id = int(pk)
        updated_rahatsizlik = self.rahatsizlik_service.update_rahatsizlik(rahatsizlik)
        return Response(updated_rahatsizlik.__dict__)

    def destroy(self, request, pk=None):
        if self.rahatsizlik_service.delete_rahatsizlik(int(pk)):
            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response(status=status.HTTP_404_NOT_FOUND)

    @action(detail=False, methods=['get'])
    def search(self, request):
        name = request.query_params.get('name', '')
        rahatsizliklar = self.rahatsizlik_service.search_rahatsizliklar(name)
        return Response([rahatsizlik.__dict__ for rahatsizlik in rahatsizliklar]) 