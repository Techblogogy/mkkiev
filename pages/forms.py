# coding: utf-8
from __future__ import unicode_literals

from django import forms
from django.conf import settings
from django.utils.translation import ugettext, ugettext_lazy as _

from pages.models import Page


class PageForm(forms.ModelForm):
    url = forms.RegexField(label=_("URL"), max_length=100, regex=r'^[-\w/\.~]+$',
                           help_text=_("Example: '/about/contact/'. Make sure to have leading and trailing slashes."),
                           error_message=_("This value must contain only letters, numbers,"
                                           " dots, underscores, dashes, slashes or tildes."))

    class Meta:
        model = Page
        fields = '__all__'

    def clean_url(self):
        url = self.cleaned_data['url']
        if not url.startswith('/'):
            raise forms.ValidationError(ugettext("URL is missing a leading slash."), code='missing_leading_slash')
        if (settings.APPEND_SLASH and
                'django.middleware.common.CommonMiddleware' in settings.MIDDLEWARE_CLASSES and
                not url.endswith('/')):
            raise forms.ValidationError(ugettext("URL is missing a trailing slash."), code='missing_trailing_slash')
        return url
