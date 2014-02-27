require 'spec_helper'

shared_examples 'logstash owned' do
  it 'is owned by logstash user' do
    expect(logstash_file).to be_owned_by(logstash_user_name)
  end

  it 'is owned by logstash group' do
    expect(logstash_file).to be_grouped_into(logstash_group_name)
  end
end

shared_examples 'logstash owned dir' do
  it 'is a valid directory' do
    expect(logstash_file).to be_a_directory
  end

  it_behaves_like 'logstash owned'

  it 'has 755 permissions' do
    expect(logstash_file).to be_mode(755)
  end
end

shared_examples 'logstash owned file' do
  it 'is a file' do
    expect(logstash_file).to be_a_file
  end

  it_behaves_like 'logstash owned'

  it 'has 755 permissions' do
    expect(logstash_file).to be_mode(755)
  end

  it 'is readable' do
    expect(logstash_file).to be_readable.by_user(logstash_user_name)
  end
end
