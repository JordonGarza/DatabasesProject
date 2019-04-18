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
from .models import Currentcheckedout
from .models import Book
from .models import Movie
from .models import Sheetmusic
from .models import Bookcopy
from .models import Moviecopy
from .models import Musiccopy
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
        checkOutCount = Checkout.objects.count()
        holdsCount = Holds.objects.count()
        currentCheckCount = Currentcheckedout.objects.count()
        currentHoldsCount = Currentholds.objects.count()
        studentAmount = UsersCustomuserGroups.objects.filter(group_id = 3).count()
        adminAmount = UsersCustomuserGroups.objects.filter(group_id = 1).count()
        facultyAmount = UsersCustomuserGroups.objects.filter(group_id = 2).count()
        librarianAmount = UsersCustomuserGroups.objects.filter(group_id = 4).count()
        if request.method == "POST":
             user_id = request.user.id
        else:
            
            context = { 'checkOutCount': checkOutCount,
                        'holdsCount': holdsCount,
                        'currentCheckCount': currentCheckCount,
                        'currentHoldsCount': currentHoldsCount,
                        'studentAmount': studentAmount,
                        'adminAmount': adminAmount,
                        'facultyAmount': facultyAmount,
                        'librarianAmount': librarianAmount,
                      }
            return render(request, "reports.html", context=context)

#See link for use of login_required decorator
# https://docs.djangoproject.com/en/2.2/topics/auth/default/    
@login_required(login_url="../login/")
def seeAccount(request):
    #function redirects user to webpage for patrons (non-admin) users
    user_id = request.user.id
    holds = Currentholds.objects.filter(userid=user_id) 
    checkouts = Currentcheckedout.objects.filter(userid=user_id)
    #For holds
    temp_books = []
    temp_movies = []
    temp_music = []
    #For checkouts
    temp_books2 = []
    temp_movies2 = []
    temp_music2 = []
    for h in holds:
        item_id = getattr(h, 'itemid')
        actual_id = item_id.itemid
        actual_type = item_id.itemtype

        if actual_type == 'BOOK':
            book_copy_obj = Bookcopy.objects.get(itemid=actual_id)
            actual_isbn = getattr(book_copy_obj, 'isbn')
            book = Book.objects.get(isbn=actual_isbn)
            title = getattr(book, 'title')
            author = getattr(book, 'author')
            cover = getattr(book, 'cover_image')
            book_to_add = {'title':title, 'author':author, 'isbn':actual_isbn, 'cover':cover}
            temp_books.append(book_to_add)
        elif actual_type == "MOVIE":
            movie_copy_obj = Moviecopy.objects.get(itemid=actual_id)
            actual_isan = getattr(movie_copy_obj, 'isan')
            movie = Movie.objects.get(isan=actual_isan)
            title = getattr(movie, 'title')
            director = getattr(movie, 'director')
            cover = getattr(movie, 'cover_image')
            movie_to_add = {'title':title, 'director':director, 'isan':actual_isan, 'cover':cover}
            temp_movies.append(movie_to_add)
        elif actual_type == 'MUSIC':
            music_copy_obj = Musiccopy.objects.get(itemid=actual_id)
            actual_ismn = getattr(music_copy_obj, 'ismn')
            music = Sheetmusic.objects.get(ismn=actual_ismn)
            title = getattr(music, 'title')
            composer = getattr(music, 'composer')
            cover = getattr(music, 'cover_image')
            music_to_add = {'title':title, 'composer':composer, 'ismn':actual_ismn, 'cover':cover}
            temp_music.append(music_to_add)
    for c in checkouts:
        item_id = getattr(c, 'itemid')
        actual_id = item_id.itemid
        actual_type = item_id.itemtype

        if actual_type == 'BOOK':
            book_copy_obj = Bookcopy.objects.get(itemid=actual_id)
            actual_isbn = getattr(book_copy_obj, 'isbn')
            book = Book.objects.get(isbn=actual_isbn)
            title = getattr(book, 'title')
            author = getattr(book, 'author')
            cover = getattr(book, 'cover_image')
            book_to_add = {'title':title, 'author':author, 'isbn':actual_isbn, 'cover':cover}
            temp_books2.append(book_to_add)
        elif actual_type == "MOVIE":
            movie_copy_obj = Moviecopy.objects.get(itemid=actual_id)
            actual_isan = getattr(movie_copy_obj, 'isan')
            movie = Movie.objects.get(isan=actual_isan)
            title = getattr(movie, 'title')
            director = getattr(movie, 'director')
            cover = getattr(movie, 'cover_image')
            movie_to_add = {'title':title, 'director':director, 'isan':actual_isan, 'cover':cover}
            temp_movies2.append(movie_to_add)
        elif actual_type == 'MUSIC':
            music_copy_obj = Musiccopy.objects.get(itemid=actual_id)
            actual_ismn = getattr(music_copy_obj, 'ismn')
            music = Sheetmusic.objects.get(ismn=actual_ismn)
            title = getattr(music, 'title')
            composer = getattr(music, 'composer')
            cover = getattr(music, 'cover_image')
            music_to_add = {'title':title, 'composer':composer, 'ismn':actual_ismn, 'cover':cover}
            temp_music2.append(music_to_add)
    context = {'hold_books': temp_books, 'hold_movies': temp_movies, 'hold_music':temp_music, 'checkout_books':temp_books2, 'checkout_movies':temp_movies2, 'checkout_music':temp_music2}
    return render(request, 'account.html',context)
