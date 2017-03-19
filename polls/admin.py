# coding: utf-8
from __future__ import unicode_literals

from django.contrib import admin
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _
from .models import Choice


class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 3


class PollAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['question_text']}),
        (_('Настройки'), {'fields': ['pub_date'], 'classes': ['collapse'],}),
    ]
    inlines = [ChoiceInline]
    list_display = ('question_text', 'pub_date')
    list_filter = ['pub_date']
    search_fields = ['question_text']
    date_hierarchy = 'pub_date'

    def save_model(self, request, obj, form, change):
        if not change:
            obj.pub_date = timezone.now()
        obj.save()
