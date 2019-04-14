# users/urls.py
#Reference for adding urlpatterns:
# https://docs.djangoproject.com/en/2.2/topics/http/urls/
from django.urls import path
from . import views

urlpatterns = [
    path('signup/', views.SignUp.as_view(), name='signup'),
    path('patron/', views.loginPatron, name='patron'),
    path('checkOut/', views.add_model, name='add_model'),
    path('checkIn/', views.add_checkIn, name='add_checkIn'),
]
