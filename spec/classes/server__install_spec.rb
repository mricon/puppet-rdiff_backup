require 'spec_helper'
describe 'rdiff_backup::server::install' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :fqdn            => 'test.example.com',
          :hostname        => 'test',
          :ipaddress       => '192.168.0.1',
        })
      end

    # we do not have default values so the class should fail compile
    context 'with defaults for all parameters' do
      let (:params) {{}}

      it do
        expect {
          should compile
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
          /expects a value /)
      end
    end
      case facts[:osfamily]
      when 'RedHat'
        context 'with basic init defaults' do
          let(:params) {
            {
              'remote_path' => '/srv/rdiff',
              'package'     => 'rdiff-backup',
              'rdiff_user'  => 'rdiffbackup',
            }
          }
          it { should contain_class('rdiff_backup::server::install') }
          it { should contain_package('rdiff-backup') }
          it { should contain_file('/srv/rdiff').with(
            'ensure'  => 'directory',
            'owner'   => 'rdiffbackup',
            'group'   => 'root',
            'mode'    => '0700',
          ) }
        end
      else
      end
    end
  end
end
