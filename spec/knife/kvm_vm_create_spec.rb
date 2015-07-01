#
# Copyright:: Copyright (c) 2015 Chef Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
