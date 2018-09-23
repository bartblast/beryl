require 'opal'
require 'rake/testtask'
require 'bowser'
require 'bundler/gem_tasks'

desc 'Build the app to build/app.js'
task :build do
  Opal.append_path 'app'
  Opal.append_path 'lib'
  Dir.mkdir('build') unless File.exist?('build')
  File.binwrite 'build/app.js', Opal::Builder.build('frontend_app').to_s
end

desc 'Build and run the app'
task :run do
  Rake::Task['build'].invoke
  sh 'bundle exec rackup --port 3000 --host 0.0.0.0'
end

desc 'Test the app'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test