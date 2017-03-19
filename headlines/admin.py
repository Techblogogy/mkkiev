# coding: utf-8
from __future__ import unicode_literals

from articles.admin import BaseArticleAdmin


class HeadlineAdmin(BaseArticleAdmin):
    list_display = ('title', 'pub_date', 'publisher', 'activity', 'headline', 'ordering')
    list_editable = ('headline', 'ordering')
    list_filter = ()
