# coding: utf-8
from __future__ import unicode_literals

from django.db.models import F

from banners.models import Banner


class BannerShowCountUpdateMiddleware(object):
    def process_request(self, request):
        Banner.objects.filter(activity=True).update(show_count=F('show_count') + 1)
