require 'spec_helper'

describe 'logstash::indexer' do
  include_context 'common'

  it_behaves_like 'common install' do
    let(:install_type) { 'indexer' }
    let(:expected_config) {
<<-EOF
input {
  file {
    type => "syslog"
    path => ["/var/log/*.log", "/var/log/messages", "/var/log/syslog"]
  }

}

output {
  elasticsearch {
    embedded => true
  }

}

EOF
    }

    let(:max_heap) { '1024M' }
  end

end
