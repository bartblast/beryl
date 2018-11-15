require 'active_support/inflector'

lib_path = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

Dir['./app/migrations/*.rb'].each {|file| require file }

migrations = ObjectSpace.each_object(Class).select { |klass| klass < Beryl::Migration }

result = migrations.each_with_object([]) do |klass, statements|
  statements << klass.new.change
end

puts result.inspect