# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "rrrretry"
  gem.version       = "1.0.0"
  gem.authors       = ["Richard Schneeman"]
  gem.email         = ["richard.schneeman+rubygems@gmail.com"]
  gem.description   = %q{ Retries code when an exception is raised an arbitrary number of times }
  gem.summary       = %q{ Did I stutter? }
  gem.homepage      = "https://github.com/schneems/rrrretry"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
end
