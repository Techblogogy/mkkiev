# coding: utf-8
from __future__ import unicode_literals

from django import forms
from django.conf import settings


class TagInput(forms.TextInput):
    def render(self, name, value, attrs=None):
        if attrs is None:
            attrs = {}
            attrs['class'] = 'selectfilter'
        #list_view = reverse('json_tag_list')
        #html = super(TagAutocomplete, self).render(name, value, attrs)
        #js = '<script>$(function() {$("#%s").autocomplete({"serviceUrl":"%s"});});</script>' % (attrs['id'], list_view)
        return super(TagInput, self).render(name, value, attrs)

    class Media:
        base_url = '%s/articles/js/jquery.autocomplete/' % settings.STATIC_URL
        css = {'all': ('%s/styles.css' % base_url,)}
        js = ('%s/jquery.autocomplete-min.js' % base_url,)