require 'spec_helper'

describe 'both agent and indexer' do
  include_context 'common'

  # service is lying to us, and using `process` doesn't work right
  def ps_grep(install_type)
    backend.run_command("ps -ef | grep #{install_type}.conf | grep -v grep")
  end

  it 'has indexer running' do
    expect(ps_grep('indexer')).to be_success
  end

  it 'has agent running' do
    expect(ps_grep('agent')).to be_success
  end
end
