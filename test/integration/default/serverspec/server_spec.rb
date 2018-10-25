require 'serverspec'

set :backend, :exec

plugin_directory = '/tmp/kitchen/ohai/plugins'

describe command("ohai -d #{plugin_directory} ibm_power") do
  its(:exit_status) { should eq 0 }
  if os[:arch] == 'ppc64le'
    its(:stdout) { should match(/cpu_model.*power/) }
  else
    its(:stdout) { should_not match(/cpu_model.*power/) }
  end
end

describe yumrepo('ibm-power-tools') do
  if os[:arch] == 'ppc64le'
    it { should exist }
    it { should be_enabled }
  else
    it { should_not exist }
    it { should_not be_enabled }
  end
end

%w(ppc64-diag powerpc-utils).each do |p|
  describe package(p) do
    if os[:arch] == 'ppc64le'
      it { should be_installed }
    else
      it { should_not be_installed }
    end
  end
end
