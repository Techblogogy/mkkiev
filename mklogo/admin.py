from django.contrib import admin

class LogoAdmin(admin.ModelAdmin):
    list_display = ('slug', 'image')
