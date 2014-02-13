require 'spec_helper'

describe 'logstash::server' do
  describe group('logstash') do
    it { should exist }
  end

  describe user('logstash') do
    it { should exist }
    it { should belong_to_group('logstash') }
    it { should have_login_shell('/bin/false') }
  end
end
