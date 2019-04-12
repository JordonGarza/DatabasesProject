from django.shortcuts import render
from users.models import Book
from users.models import Movie
from users.models import Sheetmusic



def index(request):
	search_for_filter = 'Books'
	context = {}
	if request.GET.get('search_for'):
		search_for_filter = request.GET.get('search_for')

	if search_for_filter == 'Books':
		context = {
		'books' : Book.objects.all()
		}	
	elif search_for_filter == 'Movies':
		context = {
		'movies' : Movie.objects.all()
		}
	elif search_for_filter == 'Music':
		context = {
		'musics' : Sheetmusic.objects.all()
		}


	return render(request, 'catalog/home.html', context)