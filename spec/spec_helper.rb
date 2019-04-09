require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'ibm-power' }

CENTOS_7 = {
  platform: 'centos',
  version: '7.4.1708',
}.freeze

# Is this line necessary? Seems to repeat line 9.
ALL_PLATFORMS = [
  CENTOS_7,
].freeze

RSpec.configure do |config|
  config.log_level = :fatal
end
