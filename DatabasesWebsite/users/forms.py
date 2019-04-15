# users/forms.py
from django import forms
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from django.contrib.auth.models import Group
from .models import CustomUser
from .models import Checkout
from .models import Checkin
from django.forms import ModelForm

class CustomUserCreationForm(UserCreationForm):

    class Meta(UserCreationForm):
        model = CustomUser
        fields = ('username', 'email', 'first_name', 'last_name')

    def __init__(self, *args, **kwargs):
        super(CustomUserCreationForm, self).__init__(*args, **kwargs)
        self.fields['email'].required = True
        self.fields['first_name'].required = True
        self.fields['last_name'].required = True

    def save(self, commit=True):
        user = super(CustomUserCreationForm, self).save(commit=False)
        user.save()
        user.groups.add(Group.objects.get(name='STUDENT'))
        return user
    
class CustomUserChangeForm(UserChangeForm):

    class Meta:
        model = CustomUser
        fields = ('username', 'email', 'first_name', 'last_name')

class SignOut(ModelForm):
    class Meta:
        model = Checkout
        fields = ('userid', 'itemid', 'checkoutdate', 'duedate')

class SignIn(ModelForm):
    class Meta:
        model = Checkin
        fields = ('userid', 'itemid', 'datecheckedin')
