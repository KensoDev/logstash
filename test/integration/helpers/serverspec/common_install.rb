require 'spec_helper'

shared_examples 'common install' do
  include_context 'common'

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

  context 'created needed folder' do
    context 'for the basedir' do
      let(:logstash_file) { file_for }
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

  context 'untars the tarball' do
    let(:logstash_file) { file_for('bin', 'logstash') }

    include_examples 'logstash owned file'
  end

  context 'config file' do
    let(:logstash_file) { file_for('conf', "#{install_type}.conf") }

    include_examples 'logstash owned file'

    it 'has the default output' do
      expect(logstash_file.content).to eq(expected_config)
    end
  end

  context 'service' do
    let(:service_name) { "logstash-#{install_type}"}
    let(:logstash_service) { service(service_name) }

    context 'service file' do
      let(:service_file) { file("/etc/init.d/#{service_name}") }

      it 'exists' do
        expect(service_file).to be_a_file
      end

      it 'is owned by root' do
        expect(service_file).to be_owned_by('root')
      end

      it 'is in group root' do
        expect(service_file).to be_grouped_into('root')
      end

      it 'is mode 755' do
        expect(service_file).to be_mode(755)
      end

      it 'has the jvm_opts' do
        regex = /LS_HEAP_SIZE=#{Regexp.escape(max_heap)}/
        expect(service_file.content).to match(regex)
      end
    end

    def send_command(cmd)
      backend.run_command("service #{service_name} #{cmd} 2> /dev/null || true")
    end

    context 'when started' do
      before do
        send_command(:start)
      end

      it 'is running' do
        expect(logstash_service).to be_running
      end
    end

    context 'when stopped' do
      before do
        send_command(:stop)
      end

      it 'can be stopped' do
        expect(logstash_service).to_not be_running
      end
    end
  end

end
