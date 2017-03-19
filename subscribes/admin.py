# coding: utf-8
from __future__ import unicode_literals

from django.contrib import admin

from subscribes.models import Subscribe


@admin.register(Subscribe)
class SubscribeAdmin(admin.ModelAdmin):
    list_display = ('email', 'activity', 'create_date')
    list_editable = ('activity',)
    list_filter = ('activity',)