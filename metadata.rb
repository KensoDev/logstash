name             'logstash'
maintainer       'OrgSync, Inc.'
maintainer_email 'ops@orgsync.com'
license          'All rights reserved'
description      'Installs/Configures logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

recipe 'logstash::default', 'Install and configure logstash'
recipe 'logstash::indexer', 'Install and configure a logstash indexer'
recipe 'logstash::agent', 'Install and configure a logstash agent'

recommends 'java', '~> 1.20'

supports 'debian'
