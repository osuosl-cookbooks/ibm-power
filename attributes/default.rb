default['ibm-power']['repo_url'] = 'http://public.dhe.ibm.com/software/server/POWER/Linux/yum/download'
default['ibm-power']['repo_package'] = 'ibm-power-repo-latest.noarch.rpm'
default['ibm-power']['ibm-power-tools'] = {
  'repositoryid' => 'ibm-power-tools',
  'description' => 'IBM Power Tools',
  'enabled' => true,
  'gpgcheck' => true,
  'gpgkey' => 'file:///opt/ibm/lop/gpg/RPM-GPG-KEY-ibm-power',
  'baseurl' => 'http://public.dhe.ibm.com/software/server/POWER/Linux/yum/OSS/RHEL/$releasever/$basearch',
}
