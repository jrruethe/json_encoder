#!/usr/bin/env ruby
require "rake/testtask"

Rake::TestTask.new do |task|
  task.pattern = "test/**/test_*.rb"
end

rule '.rb' => '.y' do |t|
  sh "racc -l -o #{t.name} #{t.source}"
end

task :compile => 'lib/json_encoder/parser.rb'

task :test => :compile
task :default => :test