require 'serverspec'
require 'pathname'

require 'common_context'
require 'file_examples'
require 'common_install'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |config|
  config.os = backend.check_os
end
