require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'redgreen'

task :default => [:test]

Rake::TestTask.new do |t|
  t.test_files = FileList['*test.rb']
  t.verbose = true
end
