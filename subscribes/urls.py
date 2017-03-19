# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url

from subscribes.views import SubscribeView, TestView

urlpatterns = [
    url(r'^$', SubscribeView.as_view(), name='subscribes-index'),
    url(r'^test/$', TestView.as_view(), name='subscribes-test'),
]
