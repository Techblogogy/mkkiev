# coding: utf-8
from __future__ import unicode_literals

from django.utils.translation import ugettext_lazy as _

from articles.models import Article
from headlines.managers import Manager


class Headline(Article):
    objects = Manager()

    class Meta:
        proxy = True
        ordering = ('ordering',)
        verbose_name = _('Маншет')
        verbose_name_plural = _('Маншет')
