# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url

from pagedown.views import upload_image

urlpatterns = [
    url(r'^upload/image/$', upload_image),
]