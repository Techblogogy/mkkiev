# coding: utf-8
from __future__ import unicode_literals

from django.db import models
from django.contrib import admin
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import F
from django.template.response import TemplateResponse
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _

from articles.filters import PublisherListFilter, TagListFilter, CategoryListFilter, FreeListFilter, CustomTagFilter
from pagedown.widgets import PageDown

# from pagedown.widgets import AdminPagedownWidget
# from pagedown.widgets import PageDownAdmin
from registration.models import User


def free_lock(modeladmin, request, queryset):
    queryset.update(free=True)
free_lock.short_description = _('Разблокировать выбранные статьи')


def make_active(modeladmin, request, queryset):
    queryset.update(activity=True)
make_active.short_description = _('Aктивировать выбранные статьи')


def make_nonactive(modeladmin, request, queryset):
    queryset.update(activity=False)
make_nonactive.short_description = _('Деактивировать выбранные статьи')


class BaseArticleAdmin(admin.ModelAdmin):
    list_display = ('title', 'pub_date', 'publisher', 'headline', 'pageviews', 'activity', 'free_')
    list_display_links = ('title',)
    list_editable = ('headline',)
    list_filter = ('category', 'tags', 'publisher', 'activity')
    date_hierarchy = 'pub_date'
    search_fields = ('title',)
    list_per_page = 300
    list_max_show_all = 500
    order = ('pub_date',)
    prepopulated_fields = {'slug': ('title',)}
    filter_vertical = ('tags', 'related')
    save_on_top = True
    save_as = True
    fieldsets = (
        (None, {'fields': ('title', 'slug', 'content', 'caption', 'pub_date', 'publisher', 'image', 'category', ('activity', 'free', 'show', 'aside'))}),
        ('Автор', {'fields': ('write_date', 'author'), 'classes': ('collapse',), 'description': 'Только для блогов'}),
        ('Настройки', {'fields': ('tags', 'related'), 'classes': ('collapse',), 'description': ''}),
    )
    actions = [free_lock, make_active, make_nonactive]
    formfield_overrides = {models.TextField: {'widget': PageDown}}
    # formfield_overrides = {models.TextField: {'widget': AdminPagedownWidget}}

    def save_model(self, request, obj, form, change):
        obj.content = obj.content.replace('<hr>', '<!--more-->').strip()
        obj.free = True
        if change:
            obj.editor = request.user
            obj.version += 1
            obj.edit_date = timezone.now()
            obj.slug_date = obj.pub_date.strftime('%Y-%m-%d')
            if not obj.publisher:
                obj.publisher = User.objects.get(id=request.user.id)
        else:
            obj.creator = request.user
            obj.publisher = User.objects.get(id=request.user.id)
            obj.pub_date = timezone.now()
            obj.slug_date = obj.pub_date.strftime('%Y-%m-%d')
        if change and obj.activity:
            query_set = self.model.objects.exclude(id=obj.id).filter(activity=True, headline=True)
            if obj.headline:
                if obj.ordering:
                    ordering = int(obj.ordering)
                    obj_ = self.model.objects.get(id=obj.id)
                    if obj_.ordering:
                        ordering_ = int(obj_.ordering)
                        if abs(ordering - ordering_) > 1:
                            if ordering < ordering_:
                                query_set.filter(ordering__gte=ordering, ordering__lt=ordering_).update(ordering=F('ordering') + 1)
                            else:
                                query_set.filter(ordering__lte=ordering, ordering__gt=ordering_).update(ordering=F('ordering') - 1)
                else:
                    obj.ordering = 1
                    query_set.filter(ordering__gte=obj.ordering).update(ordering=F('ordering') + 1)
            elif obj.ordering is not None:
                query_set.filter(ordering__gte=obj.ordering).update(ordering=F('ordering') - 1)
                obj.ordering = None
        obj.save()

    def free_(self, obj):
        return None if self.request.user == obj.editor and not obj.free else obj.free
    free_.short_description = _('Свободен')
    free_.boolean = True

    def change_view(self, request, object_id, form_url='', extra_context=None):
        try:
            obj = self.get_queryset(request).get(id=object_id)
        except ObjectDoesNotExist:
            pass
        else:
            if not obj.free and obj.editor != request.user:
                return TemplateResponse(request, 'admin/locked.html', {'object': obj}, status=403)
            obj.free = False
            obj.editor = request.user
            obj.edit_date = timezone.now()
            obj.save()
        return super(BaseArticleAdmin, self).change_view(request, object_id, form_url, extra_context)

    def changelist_view(self, request, extra_context=None):
        self.request = request
        return super(BaseArticleAdmin, self).changelist_view(request, extra_context)

    def get_queryset(self, request):
        queryset = super(BaseArticleAdmin, self).get_queryset(request)
        return queryset.prefetch_related('publisher', 'editor')

    class Media:
        js = ('http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js', '/js/articles.js')


class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ('name', 'slug', 'ordering', 'activity', 'main_category')
    list_editable = ('ordering', 'activity', 'main_category')


class TagAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ('name', 'slug', 'activity')
    search_fields = ('name',)

    def save_model(self, request, obj, form, change):
        obj.name = obj.name.strip()
        obj.save()


class ArticleAdmin(BaseArticleAdmin):
    list_filter = ('activity', FreeListFilter, CategoryListFilter, PublisherListFilter, CustomTagFilter, TagListFilter)
