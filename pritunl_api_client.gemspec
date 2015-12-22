# coding: utf-8
lib = File.expand_path( '../lib', __FILE__ )
$LOAD_PATH.unshift( lib ) unless $LOAD_PATH.include?( lib )
require 'pritunl_api_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'pritunl_api_client'
  spec.version       = PritunlApiClient::VERSION
  spec.authors       = ['Eric Terry']
  spec.email         = ['eterry1388@aol.com']

  spec.summary       = 'Pritunl Ruby API Client'
  spec.description   = "API client for Pritunl written in Ruby. Pritunl is a distributed enterprise vpn server built using the OpenVPN protocol. See the official Pritunl API documentation here: https://pritunl.com/api.html. I am not affiliated with Pritunl."
  spec.homepage      = 'http://eterry1388.github.io/pritunl_api_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split( "\x0" ).reject { |f| f.match( %r{^(test|spec|features)/} ) }
  spec.executables   = spec.files.grep( %r{^bin/} ) { |f| File.basename( f ) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
end
