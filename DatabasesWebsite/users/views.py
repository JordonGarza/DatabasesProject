# users/views.py
# reference for writing views: 
#https://docs.djangoproject.com/en/2.2/topics/http/views/
from django.urls import reverse_lazy
from django.views import generic
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django import forms
from django.contrib.auth.decorators import login_required

from .forms import CustomUserCreationForm
from .forms import SignOut
from .forms import SignIn
from .models import CustomUser
from django.views.generic.edit import FormView

class SignUp(generic.CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy('login')
    template_name = 'signup.html'
    
class checkOut(generic.CreateView):
    form_class = SignOut
    template_name = 'checkOut.html'
    success_url = reverse_lazy('login')
    

def add_model(request):
        if request.method == "POST":
            form = SignOut(request.POST)
            if form.is_valid():
                form.save()
                return redirect('/')
        else:
 
            form = SignOut()
 
            return render(request, "checkOut.html", {'form': form})

             
def add_checkIn(request):
        if request.method == "POST":
            form = SignIn(request.POST)
            if form.is_valid():
                form.save()
                return redirect('/')
        else:
 
            form = SignIn()
 
            return render(request, "checkIn.html", {'form': form})

#See link for use of login_required decorator
# https://docs.djangoproject.com/en/2.2/topics/auth/default/    
@login_required(login_url="../login/")
def loginPatron(request):
    #function redirects user to webpage for patrons (non-admin) users
    return render(request, 'patron.html')
