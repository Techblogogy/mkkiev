from optparse import make_option
import os
from urllib2 import Request, urlopen, URLError
from django.core.management.base import NoArgsCommand, CommandError


class Command(NoArgsCommand):
    option_list = NoArgsCommand.option_list + (
        make_option('-n, --dry-run', action='store_true', dest='dry_run', default=False,
                    help='Do everything except modify the filesystem.'),
    )

    def load_url(self, url):
        req = Request(url)
        try:
            response = urlopen(req)
        except URLError as e:
            if hasattr(e, 'reason'):
                raise CommandError('We failed to reach a server.\nReason: %s' % e.reason)
            elif hasattr(e, 'code'):
                raise CommandError('The server couldn\'t fulfill the request.\nError code: %s' % e.code)
        else:
            return response.read()

    def write_file(self, path, content):
        with open(path, 'wb') as f:
            f.write(content)

    def handle_noargs(self, **options):
        url = 'http://pagedown.googlecode.com/hg/'
        path = os.path.dir(__file__)
        file_names = ('Markdown.Converter.js', 'Markdown.Editor.js', 'Markdown.Sanitizer.js')
        for file_name in file_names:
            content = self.load_url(url + file_name)
            self.write_file(path + file_name, content)

        if options['dry_run']:
            raise CommandError('Poll "%s" does not exist' % poll_id)
        self.stdout.write('Successfully closed poll "%s"' % poll_id)