require 'spec_helper'
require 'chef/knife/kvm_vm_create.rb'

describe Chef::Knife::KvmVmCreate do

  subject(:knife) do
    Chef::Knife::KvmVmCreate.new(argv).tap do |c|
      allow(c).to receive(:output).and_return(true)
      c.parse_options(argv)
      c.merge_configs
    end
  end

  # describe '#run' do
  #   context 'by default' do
  #     let(:argv) { %w[ create serverurl -n fakename --vios fakevios --virtual-server fakevirt --disk fakedisk -p fakeprof ] }
  #
  #     it 'parses argv, gets password, and creates lpar' do
  #       expect(knife).to receive(:read_and_validate_params).and_call_original
  #       expect(knife).to receive(:get_password)
  #       expect(knife).to receive(:create_lpar)
  #       knife.run
  #     end
  #   end
  #
  # end


  describe '#read_and_validate_params' do
    context 'when argv is empty' do
      let(:argv) { [] }

      it 'prints usage and exits' do
        expect(knife).to receive(:read_and_validate_params).and_call_original
        expect(knife).to receive(:show_usage)
        expect { knife.run }.to raise_error(SystemExit)
      end
    end

    context 'when the host parameter is missing' do
      let(:argv) { %w[ create vm_name -u username --password password --flavor flav] }

      it 'prints usage and exits' do
        expect(knife).to receive(:read_and_validate_params).and_call_original
        expect(knife).to receive(:show_usage)
        expect { knife.run }.to raise_error(SystemExit)
      end
    end

    context 'when the username parameter is missing' do
      let(:argv) { %w[ create vm_name -h hostname --password password --flavor flav ] }

      it 'prints usage and exits' do
        expect(knife).to receive(:read_and_validate_params).and_call_original
        expect(knife).to receive(:show_usage)
        expect { knife.run }.to raise_error(SystemExit)
      end
    end

    context 'when the password parameter is missing' do
      let(:argv) { %w[ create vm_name -h hostname -u username --flavor flav ] }

      it 'prints usage and exits' do
        expect(knife).to receive(:read_and_validate_params).and_call_original
        expect(knife).to receive(:show_usage)
        expect { knife.run }.to raise_error(SystemExit)
      end
    end

    context 'when the flavor parameter is missing' do
      let(:argv) { %w[ create vm_name -h hostname -u username --password password ] }

      it 'prints usage and exits' do
        expect(knife).to receive(:read_and_validate_params).and_call_original
        expect(knife).to receive(:show_usage)
        expect { knife.run }.to raise_error(SystemExit)
      end
    end

    context 'when using static ip, fail if required network info is not provided' do
      let(:argv) { %w[ create vm_name -h hostname -u username --password password --flavor flav ] }

      it 'prints usage and exits' do
        expect(knife).to receive(:read_and_validate_params).and_call_original
        expect(knife.ui).to receive(:fatal).
          with("When using a static IP, you must specify the IP, Gateway, Netmask, and Nameserver")
        expect { knife.run }.to raise_error(SystemExit)
      end
    end


  end
end
