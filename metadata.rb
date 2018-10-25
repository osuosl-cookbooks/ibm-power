name             'ibm-power'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
license          'Apache-2.0'
chef_version     '>= 12.18' if respond_to?(:chef_version)
issues_url       'https://github.com/osuosl-cookbooks/ibm-power/issues'
source_url       'https://github.com/osuosl-cookbooks/ibm-power'
description      'Installs/Configures ibm-power'
long_description 'Installs/Configures ibm-power'
version          '2.1.0'

supports         'centos', '~> 7.0'

depends          'ohai'
depends          'yum'
