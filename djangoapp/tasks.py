# coding: utf-8
from __future__ import unicode_literals

import uwsgi
from django.core.management import call_command


def every_day_tasks(num):
    try:
        call_command('clearsessions')
    except RuntimeError:
        pass
uwsgi.register_signal(90, '', every_day_tasks)
uwsgi.add_cron(90, 0, 0, -1, -1, -1)


def execute_every_day_at_9am(num):
    try:
        call_command('sendmailtosubscribers')
    except RuntimeError:
        pass
uwsgi.register_signal(91, '', execute_every_day_at_9am)
uwsgi.add_cron(91, 0, 9, -1, -1, -1)


def execute_every_5_minutes(num):
    try:
        call_command('fetchweather')
    except RuntimeError:
        pass
    try:
        call_command('fetchcurrency')
    except RuntimeError:
        pass
uwsgi.register_signal(92, '', execute_every_5_minutes)
uwsgi.add_cron(92, -5, -1, -1, -1, -1)


def execute_every_minute(num):
    try:
        call_command('fetchgoogleanalytics')
    except RuntimeError:
        pass
uwsgi.register_signal(93, '', execute_every_minute)
uwsgi.add_timer(93, 600)

