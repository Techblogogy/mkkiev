# coding: utf-8
from __future__ import unicode_literals

from django.conf.urls import include, url
from django.views.generic import TemplateView

from articles.urls import feed_patterns, archive_patterns
from djangoapp.admin import admin_site

from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    url(r'^$', TemplateView.as_view(template_name='index.html')),
    url(r'^search/$', TemplateView.as_view(template_name='search.html')),
    url(r'^admin/', include(admin_site.urls)),
    url(r'^', include('common.urls')),
    url(r'^', include('pagedown.urls')),
    url(r'^banners/', include('banners.urls')),
    url(r'^informer/', include('informers.urls')),
    url(r'^subscribe/', include('subscribes.urls')),
    url(r'^blog/', include('blogs.urls', 'blogs')),
    url(r'^photo-gallery/', include('photogallery.urls', 'photogallery')),
    url(r'^video-gallery/', include('videogallery.urls', 'videogallery')),
    url(r'^headlines/', include('headlines.urls', 'headlines')),
    url(r'^archive/', include(archive_patterns, 'archive')),
    url(r'^polls/', include('polls.urls', 'polls')),
    url(r'^', include(feed_patterns, 'feed')),
    url(r'^', include('news.urls', 'news')),
    url(r'^', include('articles.urls', 'articles')),
]

if settings.DEBUG is True:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
