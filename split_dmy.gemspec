# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'split_dmy/version'

Gem::Specification.new do |spec|
  spec.name          = 'split_dmy'
  spec.version       = SplitDmy::VERSION
  spec.authors       = ['Colin Bruce']
  spec.email         = ['colinbruce@gmail.com']
  spec.summary       = 'Add split accessors for date fields into day, month, year parts'
  spec.description   = <<-EOF
  Adds accessors to a class so that the date can be set as a string while days, months and years can be set as integers. 
  It also allows for month as short and long text inputs, e.g. Jan, March.  It will validate resulting dates and generate 
  errors when parts are invalid and where combined parts are incorrect.
  EOF
  spec.homepage      = 'https://github.com/CeeBeeUK/split_dmy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^/bin/$}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^/(test|spec|features)/$})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'activesupport', '~> 4.0.0'
  spec.add_development_dependency 'activemodel', '~> 4.0.0'
  spec.add_development_dependency 'activerecord', '~> 4.0.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
end
