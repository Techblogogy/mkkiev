# coding: utf-8
from __future__ import unicode_literals

from django.db import models


class CategoryManager(models.Manager):
    def get_queryset(self):
        queryset = super(CategoryManager, self).get_queryset()
        return queryset


class Manager(models.Manager):
    def get_queryset(self):
        queryset = super(Manager, self).get_queryset()
        return queryset
