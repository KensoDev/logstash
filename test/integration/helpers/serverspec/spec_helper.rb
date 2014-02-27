require 'serverspec'
require 'pathname'

require 'common_context'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |config|
  config.os = backend.check_os
end
