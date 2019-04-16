# users/urls.py
from django.urls import path
from . import views
from django.contrib import admin
from django.urls import path, include
from django.views.generic.base import TemplateView

urlpatterns = [
    path('signup/', views.SignUp.as_view(), name='signup'),
    path('checkOut/', views.add_model, name='add_model'),
    path('checkIn/', views.add_checkIn, name='add_checkIn'),
    path('PayFine/', views.pay_Fine, name='pay_Fine'),
    path('account/', views.seeAccount, name='account'),
    path('reports/', views.report, name='report'),
]
