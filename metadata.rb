name             'logstash'
maintainer       'OrgSync, Inc.'
maintainer_email 'ops@orgsync.com'
license          'All rights reserved'
description      'Installs/Configures logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.2'

recipe 'logstash::default', 'Install and configure logstash'

supports 'debian'
