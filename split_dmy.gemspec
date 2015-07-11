# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'split_dmy/version'

Gem::Specification.new do |spec|
  spec.name          = "split_dmy"
  spec.version       = SplitDmy::VERSION
  spec.authors       = ["Colin Bruce"]
  spec.email         = ["colinbruce@gmail.com"]
  spec.summary       = %q{Add split accessors for date fields into day, month, year parts}
  spec.description   = %q{Use `split_dmy_accessor :date_of_birth` to provide `date_of_birth_day`, `date_of_birth_month`, `date_of_birth_year` accessors on the model.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'activemodel'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
