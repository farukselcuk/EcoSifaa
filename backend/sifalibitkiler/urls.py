from django.urls import path, include
from rest_framework.routers import DefaultRouter
from django.contrib.auth import views as auth_views
from . import views
from .views import KullaniciAramaGecmisiViewSet

router = DefaultRouter()
router.register(r'arama-gecmisi', KullaniciAramaGecmisiViewSet, basename='arama-gecmisi')

urlpatterns = [
    path('', views.home, name='home'),
    path('api/', include(router.urls)),
    path('bitkiler/', views.bitki_listesi, name='bitki_listesi'),
    path('bitki/<int:pk>/', views.bitki_detay, name='bitki_detay'),
    path('bitki/ekle/', views.bitki_ekle, name='bitki_ekle'),
    path('bitki/<int:pk>/duzenle/', views.bitki_duzenle, name='bitki_duzenle'),
    path('bitki/<int:pk>/sil/', views.bitki_sil, name='bitki_sil'),
    path('tedavi/', views.tedavi_form, name='tedavi_form'),
    path('search/bitkiler/', views.search_bitkiler, name='search_bitkiler'),
    path('rahatsizliklar/', views.rahatsizlik_listesi, name='rahatsizlik_listesi'),
    path('register/', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view(template_name='registration/login.html', next_page='home'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='home'), name='logout'),
] 