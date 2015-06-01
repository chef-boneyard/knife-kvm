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

require 'chef/knife'
require 'chef/knife/kvm_base'


class Chef
  class Knife
    class KvmVmList < Knife
      include Chef::Knife::KvmBase

      banner "knife kvm vm list"

      option :hostname,
        :short => "-h hostname",
        :long => "--hostname",
        :description => "Host Name or IP"

      option :username,
        :short => "-u USERNAME",
        :long => "--username",
        :description => "Login Username"

      option :password,
        :short => "-p PASSWORD",
        :long => "--password",
        :description => "Login Password"

      #
      # Run the plugin
      #
      def run
        read_and_validate_params
        list_vms
      end

      #
      # Reads the input parameters and validates them.
      # Will exit if it encounters an error
      #
      def read_and_validate_params
        if config[:hostname].nil? ||
            config[:username].nil? ||
            config[:password].nil?
          show_usage
          exit 1
        end
      end

      private

      def list_vms
        Net::SSH.start(config[:hostname], config[:username], :password => config[:password]) do |ssh|
          command = 'virsh --connect=qemu:///system list --all'
          result = run_remote_command(ssh, command)
          ui.info result
        end
      end
    end
  end
end
