# coding: utf-8
from __future__ import unicode_literals

from django.apps import AppConfig
from django.utils.translation import ugettext_lazy as _


class PageDownConfig(AppConfig):
    name = 'pagedown'
    verbose_name = _('PageDown')