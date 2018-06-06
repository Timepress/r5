# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'r5/version'

Gem::Specification.new do |spec|
  spec.name          = "r5"
  spec.version       = R5::VERSION
  spec.authors       = %w(mousse sionzee)
  spec.email         = %w(mousse@timepress.cz honza@timepress.cz)

  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Rails generator using Thor gem for private usage mostly}
  spec.description   = %q{Anyone can use it for inspiration}
  spec.homepage      = "http://www.timepress.cz"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #spec.bindir        = "exe"
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "thor"
end
