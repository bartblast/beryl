require 'opal'

desc 'Build app to build/app.js'
task :build do
  Opal.append_path 'app'
  Opal.append_path 'lib'
  File.binwrite 'build/app.js', Opal::Builder.build('frontend_app').to_s
end