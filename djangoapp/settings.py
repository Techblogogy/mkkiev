# coding: utf-8
import os

BASE_DIR = os.path.dirname(os.path.dirname(__file__))

DEBUG = True

ALLOWED_HOSTS = ('.haberrus.com', '.mkkiev.in.ua', '.facebook.com', '.google.com', '.yandex.ru', '127.0.0.1')

#######################################################################

SITE_TITLE = u'МК-Киев'

HEADLINE_COUNT = 18

# width=596;a=16;x=width/4.-3/4.*a;print x,x+a+x,x+a+x+a+x x+a+x+a+x+a+x

THUMBS = {
    'default_ratio': 4 / 3.,
    'line_height': 20,
    'sizes': {
        '1': {'width': 143, 'height': 95, 'is_filtered': True, 'force': True},
        '2': {'width': 305, 'ratio': 16 / 9.},
        '3': {'width': 472, 'ratio': 16 / 9.},
        '4': {'width': 630, 'ratio': 16 / 9.},
        'slidebox':   {'width': 130, 'height': 100, 'is_filtered': True},
        'informer':   {'width': 106, 'ratio': 16 / 9., 'is_filtered': True},
        'subscribes': {'width': 80, 'ratio': 1, 'is_filtered': True},
        'context_menu': {'width': 190, 'height': 120, 'is_filtered': True},
        'userpics': {'width': 60, 'height': 80, 'is_filtered': True},
        'photogallery': {'width': 280, 'height': 160, 'is_filtered': True}
    }
}

RSS_NEWS = {
    'title': u'Интернет издание «МК-Киев»',
    'link': 'http://mkkiev.in.ua',
    'description': u'Cовместный проект Издательского дома «Московский комсомолец» и МК-Киев',
    'image': 'http://mkkiev.in.ua/logo_yandex_rss.gif',
}

INFORMER_TITLE = u'Новости Киева'
INFORMER_URL = 'http://mkkiev.in.ua'
INFORMER_LOGO_PATH = '/images/LogoMK.jpg'
INFORMER_FOOTER_TITLE = u'Добавить на мой сайт'

#######################################################################

DEFAULT_FROM_EMAIL = 'webmaster@mkkiev.in.ua'
SERVER_EMAIL = 'webmaster@mkkiev.in.ua'

ADMINS = (
    ('Rim Valiulin', 'rim.valiulin@gmail.com'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'mkkiev',
        'USER': 'mkkiev',
        'PASSWORD': '',
        'HOST': '127.0.0.1',
        'PORT': '',
        'CON_MAG_AGE': None,
    }
}

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

TIME_ZONE = 'Europe/Kiev'

ugettext = lambda s: s
LANGUAGES = (
    ('ru', ugettext('Russian')),
    ('tr', ugettext('Turkish')),
)
LANGUAGE_CODE = 'ru'
LOCALE_PATHS = [os.path.join(BASE_DIR, 'locale')]

SITE_ID = 1

USE_I18N = True
USE_L10N = True
USE_TZ = True

MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'

STATIC_ROOT = os.path.join(BASE_DIR, 'public_html')
STATIC_URL = os.path.join(BASE_DIR, '/static/')
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
)

SECRET_KEY = '@!3rxi$5$6=4@8+y=1z5youa8(x&jzu%1wfy1d&k6plbr3!fe3'

MIDDLEWARE_CLASSES = (
    'banners.middleware.BannerShowCountUpdateMiddleware',
    'django.middleware.http.ConditionalGetMiddleware',
    'common.middleware.SecondPassRenderMiddleware',
    'common.middleware.UpdateCacheMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'pages.middleware.PageFallbackMiddleware',
    'common.middleware.FetchFromCacheMiddleware',
)

ROOT_URLCONF = 'djangoapp.urls'

WSGI_APPLICATION = 'djangoapp.wsgi.application'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates'),
        ],
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.template.context_processors.i18n',
                'django.template.context_processors.media',
                'django.template.context_processors.static',
                'banners.context_processors.banner',
                'django.contrib.messages.context_processors.messages',
            ],
            'debug': True,
            'loaders': [
                ('django.template.loaders.cached.Loader', [
                    'django.template.loaders.filesystem.Loader',
                    'django.template.loaders.app_directories.Loader',
                ]),
            ],
            'builtins': [
                'common.templatetags.sidebar',
                'common.templatetags.common',
            ],
            'libraries': {
            },
        }
    },
]

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.admin.apps.SimpleAdminConfig',
    'django.contrib.sitemaps',
    'common',
    'registration',
    'pagedown',
    'articles',
    'news',
    'headlines',
    'blogs',
    'photogallery',
    'videogallery',
    'informers',
    'banners',
    'annons',
    'banner_adds',
    'partners',
    'subscribes',
    'menu',
    'polls',
    'pages',
)

EMAIL_HOST = 'localhost'
EMAIL_HOST_USER = 'info@mkkiev.in.ua'
EMAIL_PORT = 25
EMAIL_SUBJECT_PREFIX = '[mkkiev.ua] '
#EMAIL_PORT = '587'
#EMAIL_HOST_PASSWORD = ''
#EMAIL_USE_TLS = 1
#EMAIL_BACKEND = 'django.core.mail.backends.filebased.EmailBackend'
#EMAIL_FILE_PATH = rel('log')

AUTH_USER_MODEL = 'registration.User'

APPEND_SLASH = False

SESSION_CACHE_ALIAS = 'default'
SESSION_ENGINE = 'django.contrib.sessions.backends.signed_cookies'

USE_ETAGS = True
# CACHE_MIDDLEWARE_ALIAS = 'default'
# CACHE_MIDDLEWARE_SECONDS = 2592000
# CACHE_MIDDLEWARE_KEY_PREFIX = 'mkkiev1'
# CACHE_MIDDLEWARE_ANONYMOUS_ONLY = False
# CACHES = {
#     'default': {
#         #'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
#         'BACKEND': 'django.core.cache.backends.memcached.PyLibMCCache',
#         'LOCATION': '127.0.0.1:11211',
#         'KEY_PREFIX': 'mkkiev',
#         'TIMEOUT': 2592000,
#     },
# }

if False:
    INTERNAL_IPS = ('81.30.184.70',)
    DEBUG_TOOLBAR_PANELS = (
        'debug_toolbar.panels.version.VersionDebugPanel',
        'debug_toolbar.panels.timer.TimerDebugPanel',
        'debug_toolbar.panels.settings_vars.SettingsVarsDebugPanel',
        'debug_toolbar.panels.headers.HeaderDebugPanel',
        #'debug_toolbar.panels.request_vars.RequestVarsDebugPanel',
        'debug_toolbar.panels.template.TemplateDebugPanel',
        'debug_toolbar.panels.sql.SQLDebugPanel',
        'debug_toolbar.panels.signals.SignalDebugPanel',
        'debug_toolbar.panels.logger.LoggingPanel',
    )
    DEBUG_TOOLBAR_CONFIG = {
        'INTERCEPT_REDIRECTS': True,
        'EXTRA_SIGNALS': [],
        'HIDE_DJANGO_SQL': True,
        'TAG': 'body',
        'ENABLE_STACKTRACES': True,
    }
    INSTALLED_APPS = INSTALLED_APPS + ('debug_toolbar',)
    MIDDLEWARE_CLASSES = ('debug_toolbar.middleware.DebugToolbarMiddleware',) + MIDDLEWARE_CLASSES

GOOGLE_OAUTH_CLIENT_ID = '70106239081-e2koqam796ttk1il810i2v3ko941bijt.apps.googleusercontent.com'
GOOGLE_OAUTH_CLIENT_SECRET = 'jp2yq5F7V3JyAiGiRDA0aeaw'
GOOGLE_OAUTH_USER_AGENT = 'mkkiev.in.ua'
GOOGLE_ANALYTICS_TABLE_ID = '50091417'
