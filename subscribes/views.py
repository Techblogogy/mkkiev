# coding: utf-8
from __future__ import unicode_literals

import hmac
import base64
from hashlib import sha1
from smtplib import SMTPException

from django.contrib import messages
from django.core.urlresolvers import reverse
from django.contrib.syndication.views import add_domain
from django.core.exceptions import ObjectDoesNotExist, ValidationError
from django.core import mail
from django.db import IntegrityError
from django.contrib.auth.decorators import login_required
from django.template.loader import render_to_string
from django.utils.decorators import method_decorator
from django.template import Context, Template
from django.conf import settings
from django.views.generic import TemplateView
from django.views.generic.list import ListView
from django.utils.translation import ugettext as _
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode

from subscribes.models import Subscribe
from subscribes.forms import SubscribeForm
from articles.models import Article

# SITE_DOMAIN_NAME = 'http://mkkiev.in.ua'
SITE_DOMAIN_NAME = 'mkkiev.in.ua'


class SubscribeView(TemplateView):
    template_name = 'subscribes/index.html'

    def make_token(self, key, email):
        return base64.encodestring(hmac.new(key, email, sha1).digest()).rstrip()

    def get(self, request, *args, **kwargs):
        email = request.GET.get('e', '')
        token = urlsafe_base64_decode(request.GET.get('t', ''))
        print token
        if email and token:
            token1 = self.make_token(settings.SECRET_KEY, email)
            is_unsubscribe = request.GET.get('d', False)
            if token == token1:
                if not is_unsubscribe:
                    try:
                        Subscribe.objects.create(email=email)
                    except (IntegrityError, ValidationError):
                        messages.error(request, _('Этот почтовый адрес уже есть в списке рассылок'))
                    else:
                        messages.success(request, _('Вы успешно подписались на рассылку'))
                else:
                    try:
                        subscribe = Subscribe.objects.get(email=email)
                        if subscribe.activity:
                            subscribe.delete()
                        else:
                            messages.error(request, _('Ваша подписка заблокирована'))
                    except ObjectDoesNotExist:
                        messages.error(request, _('Такая подписка не существует'))
                    else:
                        messages.success(request, _('Вы успешно отписались от рассылки'))
            else:
                messages.error(request, _('Мы не можем подтвердить ваш почтовый адрес'))
        else:
            if email or token:
                messages.error(request, _('Извините, произошла ошибка'))
        return self.render_to_response(context={})

    def post(self, request, *args, **kwargs):
        form = SubscribeForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email']
            domain = add_domain(SITE_DOMAIN_NAME, '', request.is_secure())
            token = urlsafe_base64_encode(self.make_token(settings.SECRET_KEY, email))

            pretty_domain = domain.replace('http://', '').replace('https://', '').replace('//', '')
            from_email_name = getattr(settings, 'SUBSCRIBES_FROM_EMAIL_NAME', 'no-reply')
            from_email = '%s@%s' % (from_email_name, pretty_domain)

            subject = _('Подтверждение подписки для %s' % pretty_domain)
            url = '%s%s?t=%s&e=%s' % (domain, reverse('subscribes-index'), token, email)

            print email, domain, pretty_domain, url, from_email_name, from_email

            text_message = '%s:\n\n%s\n\n--\n%s' % (_('Скопируйте ссылку в браузер.'), url, domain)
            html_message = '<a href="%s">%s</a><br><br>---<br>%s' % (url, _('Подписаться на рассылку.'), domain)

            connection = mail.get_connection()
            connection.open()
            msg = mail.EmailMultiAlternatives(subject, text_message, from_email, [email])
            msg.attach_alternative(html_message, 'text/html')
            try:
                msg.send()
                messages.success(request, _('На ваш почтовый адрес выслано подтверждение подписки.<br>Проверьте ваш почтовый ящик'))
            except SMTPException:
                messages.error(request, _('Ошибка в отправке подтверждения подписки на ваш почтовый адрес'))
                raise
            finally:
                connection.close()
        else:
            for error in form.errors['email']:
                messages.error(request, error)
        return self.render_to_response(context={})


class TestView(ListView):
    template_name = 'subscribes/test.html'
    context_object_name = 'article_list'
    queryset = Article.objects.filter(activity=True).order_by('-pub_date')[:5]
    domain = add_domain(SITE_DOMAIN_NAME, '', False)

    def get_context_data(self, **kwargs):
        context = super(TestView, self).get_context_data(**kwargs)
        context['domain'] = self.domain
        context['pretty_domain'] = self.domain.replace('http://','').replace('https://','').replace('//','').replace('www','')
        context['subject'] = getattr(settings, 'SUBSCRIBES_SUBJECT', _('«МК-Киев». Выбор редактора'))
        html = render_to_string('subscribes/email.html', context)
        text = render_to_string('subscribes/email.txt', context)
        email = 'no-reply@example.com'
        token = base64.encodestring(hmac.new(settings.SECRET_KEY, email, sha1).digest()).rstrip()
        unsubscribe_link = '%s%s?t=%s&e=%s&d=1' % (self.domain, reverse('subscribes-index'), token, email)
        context = Context({'unsubscribe_link': unsubscribe_link})
        return {
            'html': Template(html).render(context),
            'text': Template(text).render(context)
        }

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(TestView, self).dispatch(*args, **kwargs)
