from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Bitki, Rahatsizlik

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']
        read_only_fields = ['id']

class RahatsizlikSerializer(serializers.ModelSerializer):
    etiketler_list = serializers.SerializerMethodField()
    
    class Meta:
        model = Rahatsizlik
        fields = [
            'id', 'isim', 'aciklama', 'belirtiler', 'risk_faktorleri', 
            'onlemler', 'etiketler', 'etiketler_list', 'seviye', 'yayginlik',
            'olusturulma_tarihi', 'guncellenme_tarihi'
        ]
        read_only_fields = ['id', 'olusturulma_tarihi', 'guncellenme_tarihi']
    
    def get_etiketler_list(self, obj):
        return obj.get_etiketler_list()

class BitkiListSerializer(serializers.ModelSerializer):
    rahatsizliklar_isimleri = serializers.SerializerMethodField()
    
    class Meta:
        model = Bitki
        fields = [
            'id', 'isim', 'tip', 'resim', 'rahatsizliklar_isimleri', 
            'bilimsel_ad', 'olusturulma_tarihi', 'guncellenme_tarihi'
        ]
        read_only_fields = ['id', 'olusturulma_tarihi', 'guncellenme_tarihi']
    
    def get_rahatsizliklar_isimleri(self, obj):
        return [r.isim for r in obj.rahatsizliklar.all()]

class BitkiDetailSerializer(serializers.ModelSerializer):
    rahatsizliklar = RahatsizlikSerializer(many=True, read_only=True)
    etiketler_list = serializers.SerializerMethodField()
    mevsim_list = serializers.SerializerMethodField()
    yan_etkiler_list = serializers.SerializerMethodField()
    kontrendikasyonlar_list = serializers.SerializerMethodField()
    
    class Meta:
        model = Bitki
        fields = [
            'id', 'isim', 'tip', 'resim', 'faydalar', 'kullanim', 'hazirlama', 
            'uyarilar', 'doz', 'rahatsizliklar', 'etiketler', 'etiketler_list',
            'mevsim', 'mevsim_list', 'yan_etkiler', 'yan_etkiler_list',
            'kontrendikasyonlar', 'kontrendikasyonlar_list', 'saklama_kosullari',
            'raf_omru', 'kaynak', 'bilimsel_ad', 'aile', 'cins', 'tur',
            'olusturulma_tarihi', 'guncellenme_tarihi'
        ]
        read_only_fields = ['id', 'olusturulma_tarihi', 'guncellenme_tarihi']
    
    def get_etiketler_list(self, obj):
        return obj.get_etiketler_list()
    
    def get_mevsim_list(self, obj):
        return obj.get_mevsim_list()
    
    def get_yan_etkiler_list(self, obj):
        return obj.get_yan_etkiler_list()
    
    def get_kontrendikasyonlar_list(self, obj):
        return obj.get_kontrendikasyonlar_list()

class BitkiCreateUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bitki
        fields = [
            'isim', 'tip', 'resim', 'faydalar', 'kullanim', 'hazirlama', 
            'uyarilar', 'doz', 'rahatsizliklar', 'etiketler',
            'mevsim', 'yan_etkiler', 'kontrendikasyonlar', 'saklama_kosullari',
            'raf_omru', 'kaynak', 'bilimsel_ad', 'aile', 'cins', 'tur'
        ] 