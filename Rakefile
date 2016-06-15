require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.libs << 'test'
end

desc "Run tests"
task :default => :test

desc "Run single test with local Gem"
task :test1 do
    puts `bundle exec ./bin/podcast --dir test/ --title t --description desc --link link --image bleh`
end

desc "Run test for localhost"
task :test2 do
	test_dir = "test/"
	name = "NameOfThisPodcast"
	address = "127.0.0.1:8080"
	out_filename = "test.rss"
	image_desc = "image_desc"

	cmd = ""
	cmd += "bundle exec ./bin/podcast"
	cmd += "	--dir #{test_dir}"
	cmd += "	--title #{name}"
	cmd += "	--description #{name}"
	cmd += "	--link http://#{address}/"
	cmd += "	--base http://#{address}/#{test_dir}"
	cmd += "	--version 2.0"
	cmd += "	--out #{out_filename}"
	cmd += "	--image #{image_desc}"

	puts `#{cmd}`
end
