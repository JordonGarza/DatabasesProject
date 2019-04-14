from django.shortcuts import render
from . forms import CatalogForm
from users.models import Book
from users.models import Movie
from users.models import Sheetmusic



def index(request):
	search_for_filter = 'All'
	search_term = ''
	context = {}


	form = CatalogForm(request.GET)
	
	if form.is_valid():
		search_term = form.cleaned_data['search_term']
		search_for_filter = form.cleaned_data['filter_choice']	
	form = CatalogForm()

	if search_for_filter == 'Books' and search_term == '':
		context = {
		'form' : form,
		'books' : Book.objects.all()
		}	
	elif search_for_filter == 'Books' and search_term != '':
		context = {
		'form' : form,
		'books' : Book.objects.filter(title__icontains=search_term)
		}
	elif search_for_filter == 'Movies' and search_term == '':
		context = {
		'form' : form,
		'movies' : Movie.objects.all()
		}
	elif search_for_filter == 'Movies' and search_term != '':
		context = {
		'form' : form,
		'books' : Movie.objects.filter(title__icontains=search_term)
		}
	elif search_for_filter == 'Music' and search_term == '':
		context = {
		'form' : form,
		'music' : Sheetmusic.objects.all()
		}
	elif search_for_filter == 'Music' and search_term != '':
		context = {
		'form' : form,
		'music' : Sheetmusic.objects.filter(title__icontains=search_term)
		}
	elif search_for_filter == 'All' and search_term != '':
		context = {
		'form' : form,
		'books' : Book.objects.filter(title__icontains=search_term),
		'movies' : Movie.objects.filter(title__icontains=search_term),
		'music' : Sheetmusic.objects.filter(title__icontains=search_term)
		}
	else:
		context = {
		'form' : form,
		'books' : Book.objects.all(),
		'movies' : Movie.objects.all(),
		'music' : Sheetmusic.objects.all()
		}


	return render(request, 'catalog/home.html', context)