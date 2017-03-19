# coding: utf-8
from __future__ import unicode_literals

from django.views.generic.base import TemplateResponseMixin
from django.views.generic.list import BaseListView
from django.conf import settings

from articles.models import Article


class InformerResponseMixin(TemplateResponseMixin):
    template_name = 'informers/default.html'

    def get_template_names(self):
        template_names = super(InformerResponseMixin, self).get_template_names()
        style = self.request.GET.get('style', False)
        if style:
            template_names = ['informers/%s.html' % style.strip()] + template_names
        return template_names

    def render_to_response(self, context, **response_kwargs):
        response_kwargs['content_type'] = 'text/javascript'
        t = self.response_class(
            self.request,
            self.get_template_names(),
            context,
            **response_kwargs
        )
        t.render()
        t.content = b"document.write('%s');" % t.content.replace(b"\n", b'').replace(b'    ', b'')
        return t


class InformerView(InformerResponseMixin, BaseListView):
    def get_queryset(self):
        count = self.request.GET.get('count', 5)
        try:
            count = int(count)
            if not 0 < count < 20:
                count = 5
        except ValueError:
            count = 5
        return Article.objects.filter(activity=True)[:count]

    def get_context_data(self, **kwargs):
        context = super(InformerView, self).get_context_data(**kwargs)
        context['title'] = getattr(settings, 'INFORMER_TITLE', '')
        context['url'] = getattr(settings, 'INFORMER_URL', '')
        context['logo_path'] = getattr(settings, 'INFORMER_LOGO_PATH', '')
        context['help_path'] = getattr(settings, 'INFORMER_HELP_PATH', '')
        context['footer_title'] = getattr(settings, 'INFORMER_FOOTER_TITLE', '')
        try:
            context['v'] = int(self.request.GET.get('v', ''))
        except ValueError:
            pass
        return context