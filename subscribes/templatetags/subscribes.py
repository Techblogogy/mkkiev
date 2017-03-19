# coding: utf-8
from __future__ import unicode_literals

from django.template import Library

from ..forms import SubscribeForm


register = Library()


@register.inclusion_tag('subscribes/form.html')
def show_subscribe_form():
    form = SubscribeForm()
    return {'form': form}