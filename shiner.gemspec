# -*- encoding: utf-8 -*-
require File.expand_path('../lib/shiner/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jason Ling Xiaowei"]
  gem.email         = ["jason@jeyel.com"]
  gem.description   = 'Extract the most interesting sentences from an article.'
  gem.summary       = 'Extract the most interesting sentences from an article.'
  gem.homepage      = "https://github.com/jlxw/shiner"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "shiner"
  gem.require_paths = ["lib"]
  gem.version       = Shiner::VERSION

  gem.add_dependency "tactful_tokenizer"
  gem.add_dependency "classifier"
end
