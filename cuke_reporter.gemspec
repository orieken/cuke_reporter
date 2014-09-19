# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cuke_reporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'cuke_reporter'
  spec.version       = CukeReporter::VERSION
  spec.authors       = ['Oscar Rieken']
  spec.email         = ['oriekenjr@gmail.com']
  spec.summary       = %q{Cucumber Report takes json data and creates a nicer looking Report}
  spec.description   = %q{Use cukeforker and get back a bunch of json results files. This will munge them all together and create one customizable report}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'haml'
end
