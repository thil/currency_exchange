# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "currency_exchange/version"

Gem::Specification.new do |s|
  s.name        = "currency_exchange"
  s.version     = CurrencyExchange::VERSION
  s.authors     = ["Thil Bandara"]
  s.email       = ["tbandara@gmail.com"]
  s.homepage    = "https://github.com/thil/currency_exchange"
  s.summary     = %q{A basic library to retrieve and convert currency}
  s.description = %q{A basic library to retrieve and convert currency}

  s.rubyforge_project = "currency_exchange"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rest-client"
  s.add_development_dependency "json"
  s.add_development_dependency "rails", ">= 3.2.0"
end
