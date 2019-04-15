from django.urls import path
from django.views.generic.base import TemplateView
from . import views

urlpatterns = [
    path('account/', views.seeAccount, name='account'),
    path('', views.index, name='catalog_index'),

]
