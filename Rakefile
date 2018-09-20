require 'opal'

desc 'Build app to build/app.js'
task :build do
  Opal.append_path 'app'
  Opal.append_path 'lib'
  File.binwrite 'build/app.js', Opal::Builder.build('frontend_app').to_s
end

desc 'Build and run app'
task :run do
  Rake::Task['build'].invoke
  sh 'bundle exec rackup --port 3000 --host 0.0.0.0'
end