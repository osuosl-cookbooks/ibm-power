arch = os.arch

describe yum.repo('ibm-power-tools') do
  if arch == 'ppc64le'
    it { should exist }
    it { should be_enabled }
  else
    it { should_not exist }
    it { should_not be_enabled }
  end
end

%w(ppc64-diag powerpc-utils).each do |p|
  describe package(p) do
    if arch == 'ppc64le'
      it { should be_installed }
    else
      it { should_not be_installed }
    end
  end
end
