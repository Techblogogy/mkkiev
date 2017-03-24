from django import template
register = template.Library()

from articles.models import Article, Category, Tag

import calendar
import datetime

import pprint


@register.inclusion_tag("articles/calendar.html")
def display_calendar():
    context = {}
    # context = super(ArchiveView, self).get_context_data(**kwargs)
    # Get all unique dates from articles
    dates = Article.objects.values_list('slug_date', flat=True).order_by('slug_date')#.distinct()
    pub = Article.objects.all().values()

    # pp = pprint.PrettyPrinter(indent=4)
    print(pub)
    # for i in pub:
    #     print i.slug_date

    # Get unique years
    years = []
    for date in dates:
        year = date.year
        if year not in years:
            years.append(year)
    context['years'] = years
    # Filter calendar
    today = datetime.date.today()
    try:
        # year = int(self.kwargs['year'])
        year = 2017
        if year not in years:
            year = today.year
    except (KeyError, ValueError):
        year = today.year
    context['current_year'] = year
    current = True
    switch = False
    calendar_list = []
    for row in calendar.Calendar().yeardatescalendar(year, 2):
        rows = []
        for month in row:
            months = []
            first = True
            for week in month:
                weeks = []
                for date in week:
                    if date > today:
                        current = False
                    if date.day == 1 and not first:
                        switch = not switch
                    if not switch:
                        date = False
                    show_date = date in dates and current
                    weeks.append((show_date, date))
                    first = False
                months.append(weeks)
            rows.append(months)
        if current:
            calendar_list.append(rows)
    context['calendar'] = calendar_list
    context['week_list'] = [datetime.date(year=2012, month=1, day=day) for day in range(2, 9)]

    # print(context)

    return context
