# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.contrib import admin
from django.utils.translation import ugettext_lazy as _

from pagedown.widgets import PageDown

from pages.forms import PageForm


class PageAdmin(admin.ModelAdmin):
    form = PageForm
    fieldsets = (
        (None, {'fields': ('url', 'title', 'content')}),
        (_('Meta'), {'fields': ('keywords', 'description')}),
        (_('Advanced options'), {'classes': ('collapse',), 'fields': ('enable_comments', 'registration_required', 'template_name')}),
    )
    list_display = ('url', 'title')
    list_filter = ('enable_comments', 'registration_required')
    search_fields = ('url', 'title')

    formfield_overrides = {models.TextField: {'widget': PageDown}}


    def save_model(self, request, obj, form, change):
        print obj
        super(PageAdmin, self).save_model(request, obj, form, change)
        obj.content = obj.content.replace('<hr>', '<!--more-->').strip()


    # class Media:
    #     js = ('/static/js/vendor/ckeditor/ckeditor.js', '/static/js/admin/ckeditor.js')
