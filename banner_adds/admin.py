from django.contrib import admin

from banner_adds.models import Banneradds

class BanneraddsAdmin(admin.ModelAdmin):
    list_display = ('slug', 'url', 'image')
