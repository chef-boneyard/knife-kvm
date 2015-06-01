require 'spec_helper'
require 'chef/knife/kvm_vm_create.rb'

describe Chef::Knife::KvmVmCreate do
  class Chef
  	class Knife
			class DummyClass < Knife
				include Knife::KvmVmCreate
		  end
  	end
  end

  subject(:dummy) do
    Chef::Knife::DummyClass.new
  end

end
