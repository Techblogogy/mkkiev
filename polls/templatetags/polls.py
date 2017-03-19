# coding: utf-8
from __future__ import unicode_literals

from django.template import Library
from ..models import Poll

register = Library()


@register.inclusion_tag('polls/templatetags/polls.html', takes_context=True)
def show_polls(context):
    polled = False
    try:
        poll = Poll.objects.latest('pub_date')
        try:
            polled = ('poll_%s' % poll.pk in context['request'].session)
        except (KeyError, AttributeError):
            pass
    except Poll.DoesNotExist:
        poll = {}
    return {'poll': poll, 'polled': polled}
