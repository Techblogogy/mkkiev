# coding: utf-8
from __future__ import unicode_literals

from django.core.cache import cache
from django.core.management.base import BaseCommand


class Command(BaseCommand):

    help = 'Clear all default cache'
    can_import_settings = True

    def handle(self, *args, **options):
        cache.clear()
