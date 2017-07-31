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

require "net/ssh"

class Chef
  class Knife
    module KvmBase

      def run_remote_command(command, console = false)
        return_val = nil
        Net::SSH.start(config[:hostname], config[:username], :password => config[:password]) do |ssh|
          ssh.open_channel do |channel|
            channel.request_pty do |ch, success|
              raise "could not request pty" unless success
            end

            channel.exec command do |ch, success|
              if success
                channel.on_data do |ch, data|
                  return_val = data.chomp
                  print return_val if console
                end

                channel.on_extended_data do |ch, type, data|
                  ui.warn "STDERR: #{data}"
                end
              else
                ui.error "Something went wrong:"
                ui.error data.to_s
                exit 1
              end
            end
          end
          ssh.loop

          return_val
        end
      end
    end
  end
end
