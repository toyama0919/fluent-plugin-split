# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "fluent-plugin-split"
  gem.version     = "0.0.3"
  gem.authors     = ["Hiroshi Toyama"]
  gem.email       = "toyama0919@gmail.com"
  gem.homepage    = "https://github.com/toyama0919/fluent-plugin-split"
  gem.description = "Output Split String Plugin for fluentd"
  gem.summary     = "Output Split String Plugin for fluentd"
  gem.licenses    = ["MIT"]
  gem.has_rdoc    = false

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency "fluentd"
  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "spork"
  gem.add_development_dependency "pry"

end
