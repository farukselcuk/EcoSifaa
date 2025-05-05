from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .presentation.views import BitkiViewSet, RahatsizlikViewSet

router = DefaultRouter()
router.register(r'bitkiler', BitkiViewSet, basename='bitki')
router.register(r'rahatsizliklar', RahatsizlikViewSet, basename='rahatsizlik')

urlpatterns = [
    path('', include(router.urls)),
] 