# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tidylib/validation_errors/version'

Gem::Specification.new do |spec|
  spec.name          = "tidylib-validation_errors"
  spec.version       = Tidylib::ValidationErrors::VERSION
  spec.authors       = ["Suman Gurung"]
  spec.email         = ["sumangurung@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Simple Validation Errors}
  spec.description   = %q{Simple clean validation errors that can be used independently}
  spec.homepage      = "https://github.com/tidylib/validation_errors"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
