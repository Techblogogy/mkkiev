# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.db.models.signals import post_save, post_delete
from django.utils.translation import ugettext_lazy as _

from common.signals import invalidate_cache


class PollsConfig(AppConfig):
    name = 'polls'
    verbose_name = _('Опросы')

    def ready(self):
        from djangoapp.admin import admin_site
        from polls.models import Poll, Choice
        from polls.admin import PollAdmin
        post_save.connect(invalidate_cache, sender=Poll)
        post_delete.connect(invalidate_cache, sender=Poll)
        post_save.connect(invalidate_cache, sender=Choice)
        post_delete.connect(invalidate_cache, sender=Choice)
        admin_site.register(Poll, PollAdmin)
