from django.shortcuts import render
from . forms import CatalogForm
from . forms import HoldForm
from django.db.models import Q
from users.models import Book
from users.models import Movie
from users.models import Sheetmusic
from users.models import Bookcopy
from users.models import Musiccopy
from users.models import Moviecopy
from users.models import Holds
from users.models import UsersCustomuser
from users.models import Item

from django.contrib.auth.decorators import login_required


def index(request):
	search_for_filter = 'All'
	search_term = ''
	hold_isbn = ''
	context = {}

	#User trying to place a book on hold
	if 'hold_isbn' in request.GET: 
		hold_isbn = request.GET.get('hold_isbn')
		user_id = request.user.id
		user = UsersCustomuser.objects.get(id = user_id)
		bookid = Bookcopy.objects.filter(isbn=hold_isbn)
		bookid = bookid.filter(Q(isheld=0) & Q(checkedout=0)).first()
		bookid_item = bookid.itemid
		
		new_hold = Holds(itemid=bookid_item, userid=user)
		new_hold.save()
		bookid.isheld = 1
		bookid.save()
		book_listing = Book.objects.get(isbn=hold_isbn)
		context = {
		'type' : 1,
		'book' : book_listing
		}
		return render(request, 'catalog/confirmation.html', context)


	#User trying to place a movie on hold
	if 'hold_isan' in request.GET: 
		hold_isan = request.GET.get('hold_isan')
		user_id = request.user.id
		user = UsersCustomuser.objects.get(id = user_id)
		movieid = Moviecopy.objects.filter(isan=hold_isan)
		movieid = movieid.filter(Q(isheld=0) & Q(checkedout=0)).first()
		movieid_item = movieid.itemid
		
		new_hold = Holds(itemid=movieid_item, userid=user)
		new_hold.save()
		movieid.isheld = 1
		movieid.save()
		movie_listing = Movie.objects.get(isan=hold_isan)
		context = {
		'type' : 2,
		'movie' : movie_listing
		}
		return render(request, 'catalog/confirmation.html', context)


	#User trying to place music on hold
	if 'hold_ismn' in request.GET: 
		hold_ismn = request.GET.get('hold_ismn')
		user_id = request.user.id
		user = UsersCustomuser.objects.get(id = user_id)
		musicid = Musiccopy.objects.filter(ismn=hold_ismn)
		musicid = musicid.filter(Q(isheld=0) & Q(checkedout=0)).first()
		musicid_item = musicid.itemid
		
		new_hold = Holds(itemid=musicid_item, userid=user)
		new_hold.save()
		musicid.isheld = 1
		musicid.save()
		music_listing = Sheetmusic.objects.get(ismn=hold_ismn)
		context = {
		'type' : 3,
 		'music' : music_listing
		}
		return render(request, 'catalog/confirmation.html', context)
		





	form = CatalogForm(request.GET)
	
	
	if form.is_valid():
		search_term = form.cleaned_data['search_term']
		search_for_filter = form.cleaned_data['filter_choice']	

	

	form = CatalogForm()
	form2 = HoldForm()

	if search_for_filter == 'Books' and search_term == '':
		context = {
		'form' : form,
		'books' : Book.objects.all()
		}	
	elif search_for_filter == 'Books' and search_term != '':
		context = {
		'form' : form,
		'books' : Book.objects.filter(
			Q(title__icontains=search_term) 
			| Q(author__icontains=search_term)
			| Q(isbn__icontains=search_term)) 
		}
	elif search_for_filter == 'Movies' and search_term == '':
		context = {
		'form' : form,
		'movies' : Movie.objects.all()
		}
	elif search_for_filter == 'Movies' and search_term != '':
		context = {
		'form' : form,
		'movies' : Movie.objects.filter(
			Q(title__icontains=search_term) 
			| Q(director__icontains=search_term)
			| Q(isan__icontains=search_term)) 
		}
	elif search_for_filter == 'Music' and search_term == '':
		context = {
		'form' : form,
		'music' : Sheetmusic.objects.all()
		}
	elif search_for_filter == 'Music' and search_term != '':
		context = {
		'form' : form,
		'music' : Sheetmusic.objects.filter(
			Q(title__icontains=search_term) 
			| Q(composer__icontains=search_term)
			| Q(ismn__icontains=search_term)) 
		}
	elif search_for_filter == 'All' and search_term != '':
		context = {
		'form' : form,
		'form2' : form2,
		'books' : Book.objects.filter(
			Q(title__icontains=search_term) 
			| Q(author__icontains=search_term)
			| Q(isbn__icontains=search_term)),
		'movies' : Movie.objects.filter(
			Q(title__icontains=search_term) 
			| Q(director__icontains=search_term)
			| Q(isan__icontains=search_term)),
		'music' : Sheetmusic.objects.filter(
			Q(title__icontains=search_term) 
			| Q(composer__icontains=search_term)
			| Q(ismn__icontains=search_term)) 
		}
	else:
		context = {
		'form' : form,
		'form2' : form2,
		'books' : Book.objects.all(),
		'movies' : Movie.objects.all(),
		'music' : Sheetmusic.objects.all()
		}


	return render(request, 'catalog/home.html', context)


#See link for use of login_required decorator
# https://docs.djangoproject.com/en/2.2/topics/auth/default/    
@login_required(login_url="../login/")
def seeAccount(request):
    #function redirects user to webpage for patrons (non-admin) users
    holds = Holds.objects.all()
    books = Book.objects.all()
    context = {'holds': holds, 'books':books}
    return render(request, 'catalog/account.html',context)