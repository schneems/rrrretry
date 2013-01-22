# encoding: UTF-8
require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rdoc/task'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end



require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "rrrretry"
  gem.homepage    = "http://github.com/schneems/rrrretry"
  gem.license     = "MIT"
  gem.summary     = %Q{re-run your code}
  gem.description = %Q{did i stutter?}
  gem.email       = "richard.schneeman@gmail.com"
  gem.authors     = ["schneems"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new
