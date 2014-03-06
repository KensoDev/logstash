require 'spec_helper'

describe 'both agent and indexer' do
  include_context 'common'

  it 'has indexer running' do
    expect(service('logstash-indexer')).to be_running
  end

  it 'has agent running' do
    expect(service('logstash-agent')).to be_running
  end
end
