plugin_directory = '/tmp/kitchen/ohai/plugins'

describe bash("ohai -d #{plugin_directory} ibm_power") do
  its('exit_status') { should eq 0 }
  if os.arch == 'ppc64le'
    its('stdout') { should match(/cpu_model.*power/) }
  else
    its('stdout') { should_not match(/cpu_model.*power/) }
  end
end
