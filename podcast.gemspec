# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "podcast/version"

Gem::Specification.new do |s|
  s.name           = "ruby-podcast"
  s.version        = Podcast::VERSION
  s.authors        = ["Ed Summers", "Darren Greaves"]
  s.email          = ["github@djgreaves.org"]
  s.homepage       = "https://github.com/boncey/ruby-podcast"
  s.summary        = %q{Create podcasts from MP3 files}
  s.description    = %q{Iterate over a directory of mp3 files and write out a podcast RSS file}

  s.rubyforge_project = "ruby-podcast"

  s.files           = %w{bin/podcast lib/podcast.rb lib/podcast/version.rb}
  s.test_files      = %w{test/test_podcast.rb}
  s.executables     = %w{podcast}
  s.require_paths   = ["lib"]
  s.add_dependency  "ruby-mp3info"
  s.add_dependency  "mp4info"
end
