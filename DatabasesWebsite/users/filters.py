# users/filters.py
from .models import Finetransactions
from .models import Checkout
import django_filters


class CheckoutFilter(django_filters.FilterSet):
    class Meta:
        model = Checkout
        fields = ['checkoutdate', ]


class FinesFilter(django_filters.FilterSet):
    class Meta:
        model = Finetransactions
        fields = ['transactiondate', ]
