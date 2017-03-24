from django.contrib import admin

class AnnonsAdmin(admin.ModelAdmin):
    list_display = ('title', 'url', 'image')
