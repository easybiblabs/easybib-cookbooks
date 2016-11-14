name              'stack-citationapi'
maintainer        'Till Klampaeckel'
maintainer_email  'till@php.net'
license           'BSD License'
description       'CitationAPI roles'
version           '0.1'
source_url        'https://github.com/till/easybib-cookbooks' if respond_to?(:source_url)
issues_url        'https://github.com/till/easybib-cookbooks/issues' if respond_to?(:issues_url)

supports 'ubuntu'

depends 'composer'
depends 'gearmand'
depends 'ies'
depends 'ies-ssl'
depends 'haproxy'
depends 'memcache'
depends 'nginx-app'
depends 'php'
depends 'php-fpm'
depends 'php-pear'
depends 'redis'
depends 'ohai'
depends 'nodejs'
depends 'tideways'
depends 'wt-data'
