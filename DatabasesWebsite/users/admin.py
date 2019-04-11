# users/admin.py
from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.forms import UserCreationForm

from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser
from .models import Book
from .models import Bookcopy
from .models import Item
from .models import Movie
from .models import Moviecopy
from .models import Sheetmusic
from .models import Musiccopy


class UserCreateForm(UserCreationForm):

    class Meta:
        model = CustomUser
        fields = ('username', 'first_name' , 'last_name', )


class CustomUserAdmin(UserAdmin):
    add_form = UserCreateForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ['username', 'first_name', 'last_name']
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('first_name', 'last_name','email', 'username', 'password1', 'password2', ),
        }),
    )

  


admin.site.register(CustomUser, CustomUserAdmin)
admin.site.register(Book)
admin.site.register(Bookcopy)
admin.site.register(Item)
admin.site.register(Movie)
admin.site.register(Moviecopy)
admin.site.register(Sheetmusic)
admin.site.register(Musiccopy)

