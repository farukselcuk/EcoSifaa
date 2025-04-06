from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework import permissions

from .api_views import UserViewSet, RahatsizlikViewSet, BitkiViewSet

# API Schema (Swagger/OpenAPI)
schema_view = get_schema_view(
    openapi.Info(
        title="EcoSifaa API",
        default_version='v1',
        description="EcoSifaa Şifalı Bitkiler Mobil Uygulaması API'si",
        terms_of_service="https://www.ecosifaa.com/terms/",
        contact=openapi.Contact(email="contact@ecosifaa.com"),
        license=openapi.License(name="GNU GPL v3"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

# API Router'ı oluşturalım
router = DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'rahatsizliklar', RahatsizlikViewSet)
router.register(r'bitkiler', BitkiViewSet)

urlpatterns = [
    # JWT Token
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    
    # API documentation
    path('swagger<format>/', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    
    # API endpoints
    path('', include(router.urls)),
    
    # Rest framework browsable API login/logout
    path('auth/', include('rest_framework.urls', namespace='rest_framework')),
] 