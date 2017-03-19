from django import template
from partners.models import Partner


register = template.Library()


@register.inclusion_tag('partners/partners.html')
def display_banner():
    res = Partner.objects.all()
    return {'objs': res}
