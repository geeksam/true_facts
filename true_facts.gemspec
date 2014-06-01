# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'true_facts/version'

Gem::Specification.new do |spec|
  spec.name          = "true_facts"
  spec.version       = TrueFacts::VERSION
  spec.authors       = ["Sam Livingston-Gray"]
  spec.email         = ["geeksam@gmail.com"]
  spec.summary       = %q{Bizarre hybrid of an OpenStruct with "black hole" behavior, a write-once disc, and a parody of nerd behavior.}
  spec.description   = %q{...actually, the summary is about right.}
  spec.homepage      = "https://github.com/geeksam/true_facts"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.8"
end
