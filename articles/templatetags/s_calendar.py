from django import template
register = template.Library()

from django.utils.html import conditional_escape as esc
from django.utils.safestring import mark_safe

from articles.models import Article, Category, Tag

import calendar
import datetime

import pprint

from calendar import LocaleHTMLCalendar, monthrange
from datetime import date
from itertools import groupby

class ArchiveCalendar(LocaleHTMLCalendar):

    def __init__(self, dates):
        # super(ArchiveCalendar, self).__init__(locale="ru_RU.utf8")
        super(ArchiveCalendar, self).__init__()
        self.dates = dates

    def formatday(self, day, weekday):

        if day != 0:
            cssclass = self.cssclasses[weekday]

            # print date(self.year, self.month, day)
            if date(self.year, self.month, day) in self.dates:
                cssclass += ' active'

                link = '<a href="/news/%04d/%02d/%02d/">%d</a>' % (self.year, self.month, day, day)
                return self.day_cell(cssclass, '<div class="dayNumber">%s</div>' % link)
            return self.day_cell(cssclass, '<div class="dayNumber">%d</div>' % day)

        return self.day_cell('noday', '&nbsp;')

    def formatmonth(self, year, month):
        self.year, self.month = year, month
        # return super(ArchiveCalendar, self).formatmonth(year, month)

        v = []
        a = v.append
        a('<table class="archive-month">')
        a('\n')
        a(self.formatmonthname(year, month, withyear=True))
        a('\n')
        a(self.formatweekheader())
        a('\n')
        for week in self.monthdays2calendar(year, month):
            a(self.formatweek(week))
            a('\n')
        a('</table>')
        a('\n')
        return ''.join(v)

    def day_cell(self, cssclass, body):
        return '<td class="%s">%s</td>' % (cssclass, body)


def add_months(sourcedate,months):
    month = sourcedate.month - 1 + months
    year = int(sourcedate.year + month / 12 )
    month = month % 12 + 1
    day = min(sourcedate.day,calendar.monthrange(year,month)[1])
    return datetime.date(year,month,day)

@register.inclusion_tag("articles/calendar.html")
def display_calendar():
    context = {}

    # Get all unique dates from articles
    dates = Article.objects.values_list('slug_date', flat=True).order_by('slug_date').distinct()

    d_min = min(dates)
    d_max = max(dates)
    today = datetime.date.today()

    cals = []

    today_t = False
    while d_min.month <= d_max.month:
        # print d_min.year, d_min.month

        cal = ArchiveCalendar(dates).formatmonth(d_min.year, d_min.month)

        if today.month == d_min.month and today.year == d_min.year:
            cals.append({"dat": mark_safe(cal), "display": "block"})
            today_t = True
        else:
            cals.append({"dat": mark_safe(cal), "display": "none"})
        # cals.append(mark_safe(cal))

        d_min = add_months(d_min, 1)

    if not today_t:
        cals[len(cals)-1]['display'] = "block"

    # print cals


    return {"cals": cals}
