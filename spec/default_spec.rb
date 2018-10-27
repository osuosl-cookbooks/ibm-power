require_relative 'spec_helper'

describe 'ibm-power::default' do
  ALL_PLATFORMS.each do |p|
    context "#{p[:platform]} #{p[:version]}" do
      %w(ppc64 ppc64le).each do |arch|
        context arch do
          cached(:chef_run) do
            ChefSpec::SoloRunner.new(p) do |node|
              node.automatic['kernel']['machine'] = arch
            end.converge(described_recipe)
          end
          it do
            expect(chef_run).to create_remote_file_if_missing(
              ::File.join(
                Chef::Config[:file_cache_path],
                'ibm-power-repo-latest.noarch.rpm'
              )
            ).with(
              source: 'http://public.dhe.ibm.com/software/server/POWER/' \
                      'Linux/yum/download/ibm-power-repo-latest.noarch.rpm'
            )
          end
          it do
            expect(chef_run).to install_rpm_package(
              ::File.join(
                Chef::Config[:file_cache_path],
                'ibm-power-repo-latest.noarch.rpm'
              )
            )
          end
          it do
            expect(chef_run).to create_yum_repository('ibm-power-tools')
              .with(
                repositoryid: 'ibm-power-tools',
                description: 'IBM Power Tools',
                enabled: true,
                gpgcheck: true,
                gpgkey: 'file:///opt/ibm/lop/gpg/RPM-GPG-KEY-ibm-power',
                baseurl: 'http://public.dhe.ibm.com/software/server/POWER/' \
                         'Linux/yum/OSS/RHEL/$releasever/$basearch'
              )
          end
          %w(ppc64-diag powerpc-utils).each do |package|
            it do
              expect(chef_run).to install_package(package)
            end
          end
        end
      end
      context 'x86_64' do
        cached(:chef_run) do
          ChefSpec::SoloRunner.new(p).converge(described_recipe)
        end
        it do
          expect(chef_run).to_not create_remote_file_if_missing(
            ::File.join(
              Chef::Config[:file_cache_path],
              'ibm-power-repo-latest.noarch.rpm'
            )
          )
        end
        it do
          expect(chef_run).to_not install_rpm_package(
            ::File.join(
              Chef::Config[:file_cache_path],
              'ibm-power-repo-latest.noarch.rpm'
            )
          )
        end
        it do
          expect(chef_run).to_not create_yum_repository('ibm-power-tools')
        end
        %w(ppc64-diag powerpc-utils).each do |package|
          it do
            expect(chef_run).to_not install_package(package)
          end
        end
      end
    end
  end
end
