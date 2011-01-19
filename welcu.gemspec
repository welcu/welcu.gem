# -*- encoding: utf-8 -*-

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

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency("oauth2", '0.1.1')
  s.add_runtime_dependency("json")
  
  s.add_development_dependency("rake")
  s.add_development_dependency("bundler")
end
