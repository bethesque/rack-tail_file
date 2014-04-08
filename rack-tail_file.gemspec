# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/tail_file/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-tail_file"
  spec.version       = Rack::TailFile::VERSION
  spec.authors       = ["Beth"]
  spec.email         = ["beth@bethesque.com"]
  spec.description   = %q{This gem is deprecated - see rack-tail}
  spec.summary       = %q{Deprecated - see rack-tail}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.post_install_message = <<-MESSAGE
  !    The rack-tail_file gem has been deprecated and has been replaced by rack-tail.
  !    See: https://rubygems.org/gems/rack-tail
  !    And: https://github.com/bethesque/rack-tail
  MESSAGE

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "elif"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry"
end
