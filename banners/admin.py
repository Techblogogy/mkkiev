# coding: utf-8
from __future__ import unicode_literals

from django.contrib import admin
from django.db.models import Max

from banners.models import Banner


class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ('name', 'slug', 'width', 'height', 'ordering', 'main', 'activity')
    list_editable = ('ordering',)
    list_filter = ('main',)
    order = ('main', 'name')

    def save_model(self, request, obj, form, change):
        if change:
            Banner.objects.filter(category=obj).update(activity=obj.activity)
        obj.save()


class ClientAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ('name', 'slug', 'url', 'email', 'activity')
    list_editable = ('activity',)
    order = ('name',)

    def save_model(self, request, obj, form, change):
        if change:
            Banner.objects.filter(client=obj).update(activity=obj.activity)
        obj.save()


class BannerAdmin(admin.ModelAdmin):
    list_display = ('client', 'category', 'ordering', 'get_categories', 'activity', 'admin_show_count', 'admin_clicks', 'create_date')
    list_editable = ('ordering', 'activity')
    ordering = ('-activity', 'category', 'ordering')
    list_filter = ('category', 'client', 'activity')
    search_fields = ('client__name',)
    list_per_page = 100
    fieldsets = (
        (None, {'fields': ('client', 'category', 'ordering', 'categories', 'url', 'file', 'max_show_count', 'activity')}),
        ('Размеры рисунка или флеш ролика (px)', {'fields': (('width', 'height'),), 'classes': ('wide',),
                                                  'description': 'Укажите размеры, если нужно изменить значения по умолчанию взятые из категории баннера.', }),
        ('Пользовательский код баннера', {'fields': ('code',), 'classes': ('collapse',), 'description': '', }),
    )

    def get_categories(self, obj):
        return ', '.join(obj.categories.values_list('name', flat=True).order_by('name'))
    get_categories.short_description = 'Категории'

    def save_model(self, request, obj, form, change):
        if not change and not obj.ordering:
            banner = Banner.objects.filter(category=obj.category).aggregate(Max('ordering'))
            try:
                obj.ordering = banner['ordering__max'] + 1
            except TypeError:
                obj.ordering = 1
        obj.save()