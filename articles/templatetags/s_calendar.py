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

            print date(self.year, self.month, day)
            if date(self.year, self.month, day) in self.dates:
                cssclass += ' active'
                # body = ["<a href='#'>n</a>"]
                # for contest in self.contest_events[day]:
                #     body.append('<a href="%s">' % contest.get_absolute_url())
                #     body.append(esc(contest.contest.name))
                #     body.append('</a><br/>')

                link = '<a href="#">%d</a>' % (day)
                return self.day_cell(cssclass, '<div class="dayNumber">%s</div>' % link)
            return self.day_cell(cssclass, '<div class="dayNumber">%d</div>' % day)

        return self.day_cell('noday', '&nbsp;')

    def formatmonth(self, year, month):
        self.year, self.month = year, month
        return super(ArchiveCalendar, self).formatmonth(year, month)

    def day_cell(self, cssclass, body):
        return '<td class="%s">%s</td>' % (cssclass, body)


@register.inclusion_tag("articles/calendar.html")
def display_calendar():
    context = {}
    # context = super(ArchiveView, self).get_context_data(**kwargs)
    # Get all unique dates from articles
    dates = Article.objects.values_list('slug_date', flat=True).order_by('slug_date').distinct()

    def group_by_day(readings):
        field = lambda reading: reading.day
        return dict(
            [(day, list(items)) for day, items in groupby(readings, field)]
        )

    print(dates[0])
    d = group_by_day(dates)
    lCalendar = ArchiveCalendar(dates).formatmonth(2017, 3)


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


    return {"calendar": mark_safe(lCalendar)}
