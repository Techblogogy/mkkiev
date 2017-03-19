# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.utils.translation import ugettext_lazy as _


class RegistrationConfig(AppConfig):
    name = 'registration'
    verbose_name = _('Регистрация')

    def ready(self):
        from djangoapp.admin import admin_site
        from registration.admin import UserAdmin
        from registration.models import User
        from django.contrib.auth.admin import GroupAdmin
        from django.contrib.auth.models import Group
        admin_site.register(User, UserAdmin)
        admin_site.register(Group, GroupAdmin)
