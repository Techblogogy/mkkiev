# coding: utf-8
from __future__ import unicode_literals

from django import forms

from subscribes.models import Subscribe


class SubscribeForm(forms.ModelForm):
    class Meta:
        model = Subscribe
        fields = ('email',)