require 'spec_helper'

describe 'logstash::server' do

  it 'ensures the logstash group' do
    expect(group('logstash')).to exist
  end

  context 'ensures the logstash user' do
    let(:logstash_user) { user('logstash') }

    it 'exists' do
      expect(logstash_user).to exist
    end

    it 'is in the logstash group' do
      expect(logstash_user).to belong_to_group('logstash')
    end

    it 'has no shell' do
      expect(logstash_user).to have_login_shell('/bin/false')
    end
  end
end
