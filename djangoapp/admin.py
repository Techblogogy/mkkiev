# coding: utf-8
from __future__ import unicode_literals

from django.contrib.admin import AdminSite
from django.utils.translation import ugettext_lazy as _


class MyAdminSite(AdminSite):
    site_header = _('mkkiev.ua')
    site_title = 'mkkiev.ua'

admin_site = MyAdminSite()
