# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/teams/version'

Gem::Specification.new do |spec|
  spec.name        = 'mina-teams'
  spec.version     = Mina::Teams::VERSION
  spec.authors     = ['Rodrigo Coutinho']
  spec.email       = ['rcoutinho@navisite.com']
  spec.description = 'Teams web hook from mina'
  spec.summary     = 'Teams web hook from mina'
  spec.homepage    = 'https://github.com/VelocityCloud/mina-teams'
  spec.license     = 'MIT'

  spec.files = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'mina', '>= 0.3.8'
end
