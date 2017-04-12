from django import template
from mklogo.models import Logo

register = template.Library()


@register.inclusion_tag('logo/logo.html')
def display_logo():
    res = Logo.objects.get(slug="main_logo")#.values()
    return {'logo': res}
