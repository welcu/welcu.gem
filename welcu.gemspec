# -*- encoding: utf-8 -*-
require 'base64'
$:.push File.expand_path("../lib", __FILE__)
require "welcu/version"

Gem::Specification.new do |s|
  s.name        = "welcu"
  s.version     = Welcu::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sebastian Gamboa"]
  s.email       = [ Base64.decode64("c2ViYUB3ZWxjdS5jb20=\n") ]
  s.homepage    = "http://github.com/welcu/welcu.gem"
  s.summary     = "A Gem for the Welcu API"
  s.description = "A Gem for the Welcu API"

  s.files         = `git ls-files`.split("\n") rescue
    Dir['README.rdoc', 'Rakefile', 'lib/**/*', 'spec/**/*']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n") rescue Dir['spec/**/*']
  s.executables   = ( `git ls-files -- bin/*`.split("\n") rescue Dir['bin/*'] ).map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency("oauth2", '>= 0.1.1')
  s.add_runtime_dependency("json", '~> 0.4.6')
  
  s.add_development_dependency("rake")
  s.add_development_dependency("bundler", '~> 1.0.0')
end
