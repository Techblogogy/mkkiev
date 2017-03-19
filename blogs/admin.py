# coding: utf-8
from __future__ import unicode_literals

from django.contrib import admin

from articles.admin import BaseArticleAdmin
from articles.filters import AuthorListFilter, TagListFilter, PublisherListFilter


class AuthorAdmin(admin.ModelAdmin):
    list_display = ('full_name', 'username', 'is_active')
    fieldsets = (
        (None, {'fields': ('first_name', 'last_name', 'email', 'location', 'image')}),
    )


class BlogAdmin(BaseArticleAdmin):
    list_display = ('title', 'author', 'pub_date', 'publisher', 'activity')
    list_editable = ()
    list_filter = (PublisherListFilter, AuthorListFilter, TagListFilter, 'activity',)
    fieldsets = (
        (None, {'fields': ('title', 'slug', 'content', 'pub_date', 'publisher', 'image', 'tags', 'activity')}),
        ('Автор блога', {'fields': ('write_date', 'caption', 'author'), 'classes': ('wide',), 'description': '', }),
        ('Дополнительно', {'fields': ('related',), 'classes': ('collapse',), 'description': '', }),
    )