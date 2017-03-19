# coding: utf-8
from __future__ import unicode_literals

from django.contrib import admin
from django.utils.translation import ugettext_lazy as _

from articles.admin import BaseArticleAdmin
from articles.filters import TagListFilter, PublisherListFilter
from photogallery.models import Image


class ImageInline(admin.TabularInline):
    model = Image
    exclude = ('site',)
    verbose_name = _('Галерея рисунков')
    verbose_name_plural = _('Галерея рисунков')


class PhotoGalleryAdmin(BaseArticleAdmin):
    list_display = ('title', 'pub_date', 'image', 'activity')
    list_editable = ()
    list_filter = (PublisherListFilter, TagListFilter, 'activity',)
    fieldsets = (
        (None, {'fields': ('title', 'slug', 'image', 'pub_date', 'publisher', 'tags', 'activity')}),
        (_('Дополнительно'), {'fields': ('content', 'caption', 'related'),'classes': ('collapse',), 'description':'',}),
    )
    inlines = (ImageInline,)
