require 'spec_helper'

describe 'logstash::server' do
  let(:logstash_user_name) { 'logstash' }
  let(:logstash_group_name) { 'logstash' }

  it 'ensures the logstash group' do
    expect(group(logstash_group_name)).to exist
  end

  context 'ensures the logstash user' do
    let(:logstash_user) { user(logstash_user_name) }

    it 'exists' do
      expect(logstash_user).to exist
    end

    it 'is in the logstash group' do
      expect(logstash_user).to belong_to_group(logstash_group_name)
    end

    it 'has no shell' do
      expect(logstash_user).to have_login_shell('/bin/false')
    end
  end

  shared_examples 'logstash owned dir' do |dir_name = ''|
    let(:dir) { file("/opt/logstash/#{dir_name}") }

    it 'is a valid directory' do
      expect(dir).to be_a_directory
    end

    it 'is owned by logstash user' do
      expect(dir).to be_owned_by(logstash_user_name)
    end

    it 'is owned by logstash group' do
      expect(dir).to be_grouped_into(logstash_group_name)
    end

    it 'has 755 permissions' do
      expect(dir).to be_mode(755)
    end
  end

  context 'created needed folder' do
    context 'for the basedir' do
      include_examples 'logstash owned dir'
    end

    context 'for the lib dir' do
      include_examples 'logstash owned dir', 'lib'
    end

    context 'for the log dir' do
      include_examples 'logstash owned dir', 'log'
    end

    context 'for the conf dir' do
      include_examples 'logstash owned dir', 'conf'
    end
  end
end
