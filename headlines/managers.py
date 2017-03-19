# coding: utf-8
from __future__ import unicode_literals

from django.db import models


class Manager(models.Manager):
    def get_queryset(self):
        return super(Manager, self).get_queryset().filter(headline=True)
