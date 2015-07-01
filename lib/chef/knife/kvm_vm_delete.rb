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

require 'shellwords'
require 'chef/knife'
require 'chef/knife/kvm_base'

class Chef
  class Knife
    class KvmVmDelete < Knife
      include Chef::Knife::KvmBase

      banner "knife kvm vm delete NAME"

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
        delete_vm
      end

      #
      # Reads the input parameters and validates them.
      # Will exit if it encounters an error
      #
      def read_and_validate_params
        if @name_args.length < 1
          show_usage
          exit 1
        end

        if config[:hostname].nil? ||
            config[:username].nil? ||
            config[:password].nil?
          show_usage
          exit 1
        end
      end

      private

      def delete_vm
        ui.info "Destroying machine"
        command = "virsh --connect qemu:///system destroy #{@name_args[0]}"
        result = run_remote_command(command, config[:debug])

        ui.info "Nuking machine"
        command = "virsh --connect qemu:///system undefine #{@name_args[0]} --remove-all-storage"
        result = run_remote_command(command, config[:debug])
      end
    end
  end
end
