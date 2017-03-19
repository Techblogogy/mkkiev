# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.utils.translation import ugettext_lazy as _


class SubscribesConfig(AppConfig):
    name = 'subscribes'
    verbose_name = _('Подписка')

    def ready(self):
        from djangoapp.admin import admin_site
        from subscribes.admin import SubscribeAdmin
        from subscribes.models import Subscribe
        admin_site.register(Subscribe, SubscribeAdmin)
