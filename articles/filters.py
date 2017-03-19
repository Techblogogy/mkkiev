# coding: utf-8
from __future__ import unicode_literals

from django.contrib.admin import SimpleListFilter
from django.utils.translation import ugettext_lazy as _


class CategoryListFilter(SimpleListFilter):
    title = _('Категории')
    parameter_name = 'category'

    def lookups(self, request, model_admin):
        queryset = model_admin.get_queryset(request)
        queryset = queryset.order_by('category').distinct()
        return queryset.values_list('category__id', 'category__name')

    def queryset(self, request, queryset):
        return queryset.filter(category__id=self.value()) if self.value() else queryset


class TagListFilter(SimpleListFilter):
    title = _('Теги')
    parameter_name = 'tags'
    template = "admin/tag_filter.html"

    def lookups(self, request, model_admin):
        queryset = model_admin.get_queryset(request)
        queryset = queryset.exclude(tags=None).order_by('tags__name').distinct()
        return queryset.values_list('tags__id', 'tags__name')

    def queryset(self, request, queryset):
        return queryset.filter(tags__id=self.value()) if self.value() else queryset


class CustomTagFilter(SimpleListFilter):
    title = _('Теги')
    parameter_name = 'custom_tags'

    def lookups(self, request, model_admin):
        return (
            ('8', _('Турция')),
            ('26', _('Россия')),
        )

    def queryset(self, request, queryset):
        value = self.value()
        if value is None:
            return queryset
        elif value.startswith('-'):
            return queryset.exclude(tags=value[1:])
        else:
            return queryset.filter(tags=value)


class PublisherListFilter(SimpleListFilter):
    title = _('Опубликовал')
    parameter_name = 'publisher'

    def lookups(self, request, model_admin):
        queryset = model_admin.get_queryset(request)
        queryset = queryset.filter(publisher__isnull=False).order_by('publisher').distinct()
        publisher_list = queryset.values_list('publisher__id', 'publisher__username', 'publisher__first_name', 'publisher__last_name')
        publisher_list = ((id, username, ' '.join((first_name or '', last_name or ''))) for id, username, first_name, last_name in publisher_list)
        return tuple((((id, fullname.strip() or username) for id, username, fullname in publisher_list)))

    def queryset(self, request, queryset):
        return queryset.filter(publisher__id=self.value()) if self.value() else queryset


class AuthorListFilter(SimpleListFilter):
    title = _('Автор')
    parameter_name = 'author'

    def lookups(self, request, model_admin):
        queryset = model_admin.get_queryset(request)
        queryset = queryset.filter(author__isnull=False).order_by('author').distinct()
        author_list = queryset.values_list('author__id', 'author__username', 'author__first_name', 'author__last_name')
        author_list = ((id, username, ' '.join((first_name or '', last_name or ''))) for id, username, first_name, last_name in author_list)
        return tuple((((id, fullname.strip() or username) for id, username, fullname in author_list)))

    def queryset(self, request, queryset):
        return queryset.filter(author__id=self.value()) if self.value() else queryset


class FreeListFilter(SimpleListFilter):
    title = _('Редактирование')
    parameter_name = 'free'

    def lookups(self, request, model_admin):
        return (1, _('Свободные статьи')), (0, _('Заблокированные статьи')), (2, _('Мои статьи'))

    def queryset(self, request, queryset):
        if self.value() == '2':
            return queryset.filter(free=False, editor=request.user)
        elif self.value() == '1':
            return queryset.filter(free=True)
        elif self.value() == '0':
            return queryset.filter(free=False).exclude(editor=request.user)
        else:
            return queryset