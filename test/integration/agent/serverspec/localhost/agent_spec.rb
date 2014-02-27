require 'spec_helper'

describe 'logstash::agent' do
  include_context 'common'

  it_behaves_like 'common install' do
    let(:install_type) { 'agent' }
    let(:expected_config) {
<<-EOF
input {
  file {
    type => "syslog"
    path => ["/var/log/*.log", "/var/log/messages", "/var/log/syslog"]
  }
}
output {
  file {
    path => "/opt/logstash/log/out.log"
  }
}
EOF
    }
  end

end
