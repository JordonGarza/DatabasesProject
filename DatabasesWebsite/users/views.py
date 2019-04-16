# users/views.py
from django.urls import reverse_lazy
from django.views import generic
from django import forms
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from .forms import CustomUserCreationForm
from .forms import SignOut
from .forms import SignIn
from .forms import pay
from .models import CustomUser
from .models import UsersCustomuser
from .models import Finetransactions
from .models import Currentholds
from .models import Book
from .models import Bookcopy
from .models import Checkout
from django.views.generic.edit import FormView
import datetime

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

def pay_Fine(request):

        user_id = request.user.id
        finesObj = Finesrecord.objects.get(userid= user_id)
        theFine = getattr(finesObj, 'amount')
        if request.method == "POST":
            form = pay(request.POST)
            if form.is_valid():
                model_instance = form.save(commit=False)
                TheAmount = form.instance.amount
                user_id = request.user.id
                user = UsersCustomuser.objects.get(id = user_id)
                TransDate = datetime.date.today()
                TheType = 'PAYMENT'
                model_instance = Finetransactions(userid = user, transtype = TheType, transactiondate =  TransDate, amount = TheAmount)
                model_instance.save()
                return redirect('/')
        else:
 
            form = pay()
            context = { 'fine': theFine,
                        'form': form
                      }
            return render(request, "payFine.html", context=context)
        
def report(request):
        if request.method == "POST":
             user_id = request.user.id
        else:

             return render(request, "reports.html")

#See link for use of login_required decorator
# https://docs.djangoproject.com/en/2.2/topics/auth/default/    
@login_required(login_url="../login/")
def seeAccount(request):
    #function redirects user to webpage for patrons (non-admin) users
    user_id = request.user.id
    holds = Currentholds.objects.filter(userid=user_id) 
    checkouts = Checkout.objects.filter(userid=user_id)
    for h in holds:
        print((holds.itemid).itemid)
    


    context = {'holds': holds, 'checkout':checkouts}
    return render(request, 'account.html',context)
