# coding: utf-8
from __future__ import unicode_literals

from django.utils.translation import ugettext_lazy as _

from articles.admin import BaseArticleAdmin
from articles.filters import TagListFilter, PublisherListFilter


class VideoGalleryAdmin(BaseArticleAdmin):
    list_display = ('title', 'pub_date', 'video', 'activity', 'id',)
    list_editable = ()
    list_filter = (PublisherListFilter, TagListFilter, 'activity',)
    fieldsets = (
        (None, {'fields': ('title', 'slug', 'image', 'video', 'pub_date', 'publisher', 'tags', 'activity')}),
        (_('Дополнительно'), {'fields': ('content', 'caption', 'related'),'classes': ('collapse',), 'description':'',}),
    )