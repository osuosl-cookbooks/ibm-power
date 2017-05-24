#
# Cookbook Name:: ibm-power
# Recipe:: default
#
# Copyright 2016 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['kernel']['machine']
when 'ppc64', 'ppc64le'
  case node['platform_family']
  when 'rhel'
    remote_file ::File.join(
      Chef::Config[:file_cache_path],
      node['ibm-power']['repo_package']
    ) do
      source node['ibm-power']['repo_url'] + '/' + \
             node['ibm-power']['repo_package']
      action :create_if_missing
    end
    rpm_package ::File.join(
      Chef::Config[:file_cache_path],
      node['ibm-power']['repo_package']
    )
    yum_repository 'ibm-power-tools' do
      node['ibm-power']['ibm-power-tools'].each do |key, value|
        send(key.to_sym, value)
      end
    end
    %w(ppc64-diag powerpc-utils).each do |p|
      package p
    end

  when 'debian'
    case node ['kernel']['machine']
    when 'ppc64'
      apt_repository 'unstable' do
        uri 'http://debian.osuosl.org/debian'
        components ['unstable', 'main']
      end
      %w(ppc64-diag).each do |p|
        package p
      end
    when 'ppc64le'
      apt_repository 'stretch' do
        uri 'http://debian.osuosl.org/debian'
        components ['stretch', 'main']
      end
      %w(ppc64-diag).each do |p|
        package p
      end
    end

  when 'opensuse'
    %w(ppc64-diag).each do |p|
      package p
    end

  when 'ubuntu'
    %w(ppc64-diag).each do |p|
      package p
    end
end
