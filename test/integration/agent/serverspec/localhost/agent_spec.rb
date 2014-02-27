require 'spec_helper'

describe 'logstash::agent' do
  include_context 'common'

  context 'service' do
    it 'is running initially' do
      expect(service('logstash-agent')).to be_running
    end
  end

end
