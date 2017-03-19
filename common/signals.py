# coding: utf-8
from __future__ import unicode_literals

from django.core.cache import cache


def invalidate_cache(sender, **kwargs):
    cache.clear()
