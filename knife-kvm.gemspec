# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-kvm/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-kvm"
  spec.version       = Knife::Kvm::VERSION
  spec.authors       = ["Scott Hain"]
  spec.email         = ["shain@chef.io"]
  spec.summary       = %q{A knife plugin to interact with kvm}
  spec.description   = %q{A knife plugin to interact with kvm}
  spec.homepage      = "http://github.com/chef/knife-kvm"
  spec.license       = "Apache2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "chef", "~> 12.0"
  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
