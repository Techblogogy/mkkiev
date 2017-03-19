# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import url
from django.views.generic import TemplateView

from informers.views import InformerView

urlpatterns = [
    url(r'^help/$', TemplateView.as_view(template_name='informers/index.html'), name='informer_help'),
    url(r'^$', InformerView.as_view(), name='informer'),
]