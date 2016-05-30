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
