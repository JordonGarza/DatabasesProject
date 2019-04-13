# users/views.py
# reference for writing views: 
#https://docs.djangoproject.com/en/2.2/topics/http/views/
from django.urls import reverse_lazy
from django.views import generic
from django.http import HttpResponse
from django.shortcuts import render
from django.contrib.auth.decorators import login_required

from .forms import CustomUserCreationForm

class SignUp(generic.CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy('login')
    template_name = 'signup.html'

#See link for use of login_required decorator
# https://docs.djangoproject.com/en/2.2/topics/auth/default/    
@login_required(login_url="../login/")
def loginPatron(request):
    #function redirects user to webpage for patrons (non-admin) users
    return render(request, 'patron.html')