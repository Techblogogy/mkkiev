from django import template
from mklogo.models import Logo

register = template.Library()


@register.inclusion_tag('logo/logo.html')
def display_logo():
    res = Logo.objects.get(slug="main_logo")#.values()
    return {'logo': res}
# 
# @register.inclusion_tag('logo/logo_side.html')
# def display_logo_side():
#     res = Logo.objects.get(slug="side_logo")#.values()
#     return {'logo': res}
