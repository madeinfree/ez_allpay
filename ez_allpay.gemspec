# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ez_allpay/version'

Gem::Specification.new do |spec|
  spec.name          = "ez_allpay"
  spec.version       = EzAllpay::VERSION
  spec.authors       = ["Whien"]
  spec.email         = ["sal95610@gmail.com"]
  spec.summary       = "ez to allpay api"
  spec.description   = "ez to get allpay"
  spec.homepage      = "http://ksustd.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

end
