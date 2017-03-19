# coding: utf-8
from __future__ import unicode_literals

from django.db import models


class Manager(models.Manager):
    def get_queryset(self):
        queryset = super(Manager, self).get_queryset()
        return queryset.filter(category__slug='blog')


class AuthorManager(models.Manager):
    def get_queryset(self):
        queryset = super(AuthorManager, self).get_queryset()
        return queryset.filter(author_articles__isnull=False).distinct()
