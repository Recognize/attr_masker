# -*- encoding: utf-8 -*-
# (c) 2017 Ribose Inc.

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attr_masker/version'

Gem::Specification.new do |gem|
  gem.name              = 'attr_masker'
  gem.version           = AttrMasker::Version.string
  gem.authors           = ['Ribose Inc.']
  gem.email             = ['open.source@ribose.com']
  gem.homepage          = ''
  gem.summary           = 'Masking attributes'
  gem.description       = <<EOF
It is desired to mask certain attributes of certain models by modifying the 
database.
EOF

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('rails', '>= 4.0.0')
  gem.add_dependency('rspec', '>= 3.0')
end