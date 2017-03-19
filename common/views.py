# coding: utf-8
from __future__ import unicode_literals

import json
import codecs

from django.http import HttpResponse, HttpResponseNotFound
from django.contrib.auth.decorators import login_required
from django.utils import timezone

from articles.models import Tag, Article
from common.templatetags.namaz_umma_ru import NAMAZ_UMMA_RU


def json_tag_list(request):
    data = {}
    query = request.get('query', '').trim()
    if query:
        tags = Tag.objects.filter(name__istartswith=query).values_list('id', 'name')
        if tags:
            data = {'query': query, 'suggestions': [], 'data': []}
            for id_, name in tags:
                data['data'].append(id_)
                data['suggestions'].append(name)
    return HttpResponse(json.dumps(data), mimetype='application/json')


@login_required
def json_article_detail(request, id_):
    if not request.user.is_staff:
        return HttpResponseNotFound(mimetype='application/json')
    try:
        article = Article.objects.get(pk=id_)
    except Article.DoesNotExist:
        return HttpResponseNotFound(mimetype='application/json')
    else:
        data = {'content': article.content, 'username': request.user.username}
        try:
            data['editor_username'] = article.editor.username
            data['editor_fullname'] = article.editor.full_name()
            data['edit_date'] = article.edit_date.isoformat()
        except AttributeError:
            pass
        return HttpResponse(json.dumps(data), content_type='application/json')


def sidebar_feed(request):
    date = timezone.now().date()
    try:
        nt = NAMAZ_UMMA_RU['Moskova'][timezone.now().timetuple().tm_yday - 1]
        namaz = {'ezan': nt[0], 'gunes': nt[1], 'ogle': nt[2], 'ikindi': nt[3], 'aksam': nt[4], 'yatsi': nt[5]}
    except KeyError:
        namaz = {}
    try:
        path = '/var/www/mkkiev/common/templatetags/weather.json'
        with codecs.open(path, 'r', 'utf-8') as f:
            json_string = f.read()
        weather = json.loads(json_string)
    except (IOError, AttributeError):
        weather = {}
    try:
        path = '/var/www/mkkiev/common/templatetags/currency.json'
        with codecs.open(path, 'r', 'utf-8') as f:
            json_string = f.read()
        currency = json.loads(json_string)
    except (IOError, AttributeError):
        currency = {}
    data = {
        'date': date.isoformat(),
        'namaz': namaz,
        'weather': weather,
        'currency': currency,
    }
    return HttpResponse(json.dumps(data), content_type='application/json')
