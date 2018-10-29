require_relative '../../spec_helper'

describe 'ibm-power::ohai_plugin' do
  ALL_PLATFORMS.each do |p|
    context "#{p[:platform]} #{p[:version]}" do
      cached(:chef_run) do
        ChefSpec::SoloRunner.new(p).converge(described_recipe)
      end
      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end
      it do
        expect(chef_run).to create_ohai_plugin('ibm_power')
          .with(
            source_file: 'plugins/ibm_power.rb',
            compile_time: true
          )
      end
    end
  end
end
