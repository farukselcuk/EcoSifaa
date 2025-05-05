from django.contrib import admin
from .models import Bitki, Rahatsizlik, Karisim

@admin.register(Rahatsizlik)
class RahatsizlikAdmin(admin.ModelAdmin):
    list_display = ('isim', 'olusturulma_tarihi', 'guncellenme_tarihi')
    search_fields = ('isim', 'aciklama', 'belirtiler')
    list_filter = ('olusturulma_tarihi', 'guncellenme_tarihi')
    readonly_fields = ('olusturulma_tarihi', 'guncellenme_tarihi')
    fieldsets = (
        ('Temel Bilgiler', {
            'fields': ('isim', 'aciklama')
        }),
        ('Detaylı Bilgiler', {
            'fields': ('belirtiler', 'risk_faktorleri', 'onlemler'),
            'classes': ('collapse',)
        }),
        ('Zaman Bilgileri', {
            'fields': ('olusturulma_tarihi', 'guncellenme_tarihi'),
            'classes': ('collapse',)
        }),
    )

@admin.register(Bitki)
class BitkiAdmin(admin.ModelAdmin):
    list_display = ('isim', 'tip', 'olusturulma_tarihi', 'guncellenme_tarihi')
    list_filter = ('tip', 'olusturulma_tarihi', 'rahatsizliklar')
    search_fields = ('isim', 'faydalar', 'kullanim', 'hazirlama')
    filter_horizontal = ('rahatsizliklar',)
    readonly_fields = ('olusturulma_tarihi', 'guncellenme_tarihi')
    fieldsets = (
        ('Temel Bilgiler', {
            'fields': ('isim', 'tip', 'bilimsel_ad', 'aile', 'cins', 'tur', 'resim')
        }),
        ('Kullanım Bilgileri', {
            'fields': ('faydalar', 'kullanim', 'hazirlama', 'doz'),
        }),
        ('Uyarılar ve Notlar', {
            'fields': ('uyarilar', 'yan_etkiler', 'kontrendikasyonlar'),
            'classes': ('collapse',)
        }),
        ('Sınıflandırma', {
            'fields': ('rahatsizliklar', 'etiketler', 'mevsim'),
            'classes': ('collapse',)
        }),
        ('Ek Bilgiler', {
            'fields': ('saklama_kosullari', 'raf_omru', 'kaynak'),
            'classes': ('collapse',)
        }),
        ('Zaman Bilgileri', {
            'fields': ('olusturulma_tarihi', 'guncellenme_tarihi'),
            'classes': ('collapse',)
        }),
    )

@admin.register(Karisim)
class KarisimAdmin(admin.ModelAdmin):
    list_display = ('isim', 'olusturulma_tarihi', 'guncellenme_tarihi')
    search_fields = ('isim', 'faydalar', 'kullanim_durumu', 'hazirlama')
    filter_horizontal = ('bitkiler',)
    readonly_fields = ('olusturulma_tarihi', 'guncellenme_tarihi')
    fieldsets = (
        ('Temel Bilgiler', {
            'fields': ('isim', 'bitkiler')
        }),
        ('Kullanım Bilgileri', {
            'fields': ('faydalar', 'kullanim_durumu', 'hazirlama'),
        }),
        ('Zaman Bilgileri', {
            'fields': ('olusturulma_tarihi', 'guncellenme_tarihi'),
            'classes': ('collapse',)
        }),
    )
