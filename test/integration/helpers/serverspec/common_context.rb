require 'spec_helper'

shared_context 'common' do
  let(:logstash_user_name) { 'logstash' }
  let(:logstash_group_name) { 'logstash' }
  let(:base_dir) { '/opt/logstash' }

  def base_rel_path(*path)
    ::File.join(base_dir, *path)
  end

  def file_for(*path)
    file(base_rel_path(*path))
  end
end
