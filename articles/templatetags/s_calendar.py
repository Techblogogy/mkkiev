from django import template
register = template.Library()

from django.utils.html import conditional_escape as esc
from django.utils.safestring import mark_safe

from articles.models import Article, Category, Tag

import calendar
import datetime

import pprint

from calendar import HTMLCalendar, monthrange
from datetime import date
from itertools import groupby

class ArchiveCalendar(HTMLCalendar):

    def __init__(self, dates):
        super(ArchiveCalendar, self).__init__()
        self.dates = dates

    def formatday(self, day, weekday):

        if day != 0:
            cssclass = self.cssclasses[weekday]

            # print date(self.year, self.month, day)
            if date(self.year, self.month, day) in self.dates:
                cssclass += ' active'

                link = '<a href="#">%d</a>' % (day)
                return self.day_cell(cssclass, '<div class="dayNumber">%s</div>' % link)
            return self.day_cell(cssclass, '<div class="dayNumber">%d</div>' % day)

        return self.day_cell('noday', '&nbsp;')

    def formatmonth(self, year, month):
        self.year, self.month = year, month
        return super(ArchiveCalendar, self).formatmonth(year, month)

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
    # context = super(ArchiveView, self).get_context_data(**kwargs)
    # Get all unique dates from articles
    dates = Article.objects.values_list('slug_date', flat=True).order_by('slug_date').distinct()

    # print (min(dates))
    # print (max(dates))

    d_min = min(dates)
    d_max = max(dates)
    today = datetime.date.today()

    cals = []

    while d_min <= d_max:
        print d_min.year, d_min.month

        cal = ArchiveCalendar(dates).formatmonth(d_min.year, d_min.month)

        if today.month == d_min.month and today.year == d_min.year:
            cals.insert(0, mark_safe(cal))
        else:
            cals.append(mark_safe(cal))

        d_min = add_months(d_min, 1)

    print cals



    # year_now = datetime.datetime.now()

    # # Get unique years
    # years = []
    # for date in dates:
    #     year = date.year
    #     if year not in years:
    #         years.append(year)
    # context['years'] = years

    # # Filter calendar
    # today = datetime.date.today()
    # try:
    #     # year = int(self.kwargs['year'])
    #     year = today.year
    #     if year not in years:
    #         year = today.year
    # except (KeyError, ValueError):
    #     year = today.year
    # context['current_year'] = year
    # current = True
    # switch = False
    # calendar_list = []
    # for row in calendar.Calendar().yeardatescalendar(year, 2):
    #     rows = []
    #     for month in row:
    #         months = []
    #         first = True
    #         for week in month:
    #             weeks = []
    #             for date in week:
    #                 if date > today:
    #                     current = False
    #                 if date.day == 1 and not first:
    #                     switch = not switch
    #                 if not switch:
    #                     date = False
    #                 show_date = date in dates and current
    #                 weeks.append((show_date, date))
    #                 first = False
    #             months.append(weeks)
    #         rows.append(months)
    #     if current:
    #         calendar_list.append(rows)
    # context['calendar'] = calendar_list
    # context['week_list'] = [datetime.date(year=2012, month=1, day=day) for day in range(2, 9)]

    # print(context)

    # pp = pprint.PrettyPrinter(indent=4)
    # pp.pprint(calendar.Calendar().yeardatescalendar(year, 1))


    return {"calendar": cals}
