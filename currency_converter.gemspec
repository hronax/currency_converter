# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'currency_converter'
  spec.version       = '0.1.0'
  spec.authors       = ['hronax']
  spec.email         = ['zhr0n4x@gmail.com']
  spec.summary       = 'A Ruby gem that helps to convert currencies using free open api'
  spec.homepage      = 'https://github.com/hronax/currency-converter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'rspec', '~> 3.10'

  spec.required_ruby_version = '~> 3.0'
end
