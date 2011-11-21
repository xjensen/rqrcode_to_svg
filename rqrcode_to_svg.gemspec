# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rqrcode_to_svg/version"

Gem::Specification.new do |s|
  s.name        = "rqrcode_to_svg"
  s.version     = RqrcodeToSvg::VERSION
  s.authors     = ["Jon Jensen"]
  s.email       = ["jdjensen.public@gmail.com"]
  s.homepage    = "http://github.com/verisimilitudinous/rqrcode_to_svg"
  s.summary     = %q{Creates an SVG graphic of a QR Code.}
  s.description = %q{Creates an SVG graphic of a QR Code. Adds a to_svg method to the RQRCode::QRCode class provided by the 'rqrcode' gem.}

  s.rubyforge_project = "rqrcode_to_svg"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_development_dependency "rqrcode"
  s.add_runtime_dependency "rqrcode"
end
