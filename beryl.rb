require 'active_support/inflector'

lib_path = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

Dir['./app/entities/*.rb'].each {|file| require file }

entities = ObjectSpace.each_object(Class).select { |klass| klass < Beryl::Entity }

entities.each do |entity|
  table = ActiveSupport::Inflector.tableize(entity.name)
  puts table
end
