# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "podcast/version"

Gem::Specification.new do |s|
  s.name           = "podcast"
  s.version        = Podcast::VERSION
  s.authors        = ["Ed Summers", "Darren Greaves"]
  s.email          = ["github@djgreaves.org"]
  s.homepage       = "https://github.com/boncey/ruby-podcast"
  s.summary        = %q{Create podcasts from MP3 files}
  s.description    = %q{Iterate over a directory of mp3 files and write out a podcast RSS file}

  s.rubyforge_project = "podcast"

  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables     = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths   = ["lib"]
  s.add_dependency  "ruby-mp3info"
end
