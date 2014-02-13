name             'logstash'
maintainer       'OrgSync, Inc.'
maintainer_email 'ops@orgsync.com'
license          'All rights reserved'
description      'Installs/Configures logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'logstash::server', 'Install and configure a logstash server'
recipe 'logstash::agent', 'Install and configure a logstash agent'

recommends 'java', '~> 1.19'

supports 'debian'
