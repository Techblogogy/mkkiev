# coding: utf-8
from __future__ import unicode_literals

from django.contrib import admin

from articles.admin import BaseArticleAdmin
from articles.filters import CategoryListFilter, TagListFilter, PublisherListFilter


class NewsCategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ('name', 'slug', 'ordering', 'activity', 'main_category')
    list_editable = ('ordering', 'activity', 'main_category')


class NewsAdmin(BaseArticleAdmin):
    list_filter = (CategoryListFilter, PublisherListFilter, TagListFilter, 'activity')
    fieldsets = (
        (None, {'fields': ('title', 'slug', 'content', 'caption', 'pub_date', 'publisher', 'image', 'category', 'tags', 'activity')}),
        ('Дополнительно', {'fields': ('related',), 'classes': ('collapse',), 'description':'',}),
    )