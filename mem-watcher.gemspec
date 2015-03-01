# -*- encoding: utf-8 -*-
VERSION = "0.1.0"

Gem::Specification.new do |spec|
  spec.name          = "mem-watcher"
  spec.version       = VERSION
  spec.authors       = ["Jamon Holmgren"]
  spec.email         = ["jamon@clearsightstudio.com"]
  spec.description   = %q{Simple gem that Helps you keep an eye on your RubyMotion iOS app's memory and CPU usage. Adds a little UILabel in the top left of the screen that shows CPU % and memory usage in MB.}
  spec.summary       = %q{Simple gem that Helps you keep an eye on your RubyMotion iOS app's memory and CPU usage.}
  spec.homepage      = "https://github.com/jamonholmgren/mem-watcher"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
