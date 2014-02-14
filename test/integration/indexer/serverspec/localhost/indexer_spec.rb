require 'spec_helper'

describe 'logstash::indexer' do
  let(:logstash_user_name) { 'logstash' }
  let(:logstash_group_name) { 'logstash' }
  let(:base_dir) { '/opt/logstash' }

  def base_rel_path(*path)
    ::File.join(base_dir, *path)
  end

  def file_for(*path)
    file(base_rel_path(*path))
  end

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

  context 'created needed folder' do
    context 'for the basedir' do
      let(:logstash_file) { file_for }
      include_examples 'logstash owned dir'
    end

    context 'for the lib dir' do
      let(:logstash_file) { file_for('lib') }
      include_examples 'logstash owned dir'
    end

    context 'for the log dir' do
      let(:logstash_file) { file_for('log') }
      include_examples 'logstash owned dir'
    end

    context 'for the conf dir' do
      let(:logstash_file) { file_for('conf') }
      include_examples 'logstash owned dir'
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

  context 'downloads the jar' do
    let(:logstash_file) { file_for('lib', 'logstash-1.3.3.jar') }

    include_examples 'logstash owned file'
  end

  context 'creates a symlink' do
    let(:logstash_file) { file_for('lib', 'logstash.jar') }

    include_examples 'logstash owned'

    it 'is linked to the downloaded jar' do
      expect(logstash_file).to be_linked_to(base_rel_path('lib', 'logstash-1.3.3.jar'))
    end
  end

end
