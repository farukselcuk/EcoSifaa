"""
URL configuration for ecosifa project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

# Admin başlıklarını ayarla
admin.site.site_header = getattr(settings, 'ADMIN_SITE_HEADER', 'EcoSifaa Yönetim Paneli')
admin.site.site_title = getattr(settings, 'ADMIN_SITE_TITLE', 'EcoSifaa Admin')
admin.site.index_title = getattr(settings, 'ADMIN_INDEX_TITLE', 'Site Yönetimi')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include('sifalibitkiler.api_urls')),  # API endpoint'leri
    path('', include('sifalibitkiler.urls')),             # Web uygulaması
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Debug modunda statik dosyaları serve etmek için
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
