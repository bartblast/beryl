require 'json'

module Beryl
  module Deserializer
    extend self

    def deserialize(obj, json = true)
      # puts "deserialize: #{obj}"
      obj = JSON.parse(obj) if json
      # puts 'after'
      obj.is_a?(Array) ? array(obj) : item(obj)
    end

    private

    def array(obj)
      obj.each_with_object([]) { |item, result| result << deserialize(item, false) }
    end

    def item(obj)
      # puts "object = #{obj.inspect}"
      # puts "class = #{obj.class}"
      case obj['class']
      when 'Float'
        obj['value'].to_f
      when 'Hash'
        obj['value'].each_with_object({}) do |(key, value), result|
          # puts "item, key = #{key}, value = #{value}"
          result[key.to_sym] = deserialize(value, false)
        end
      when 'Integer'
        obj['value'].to_i
      when 'String'
        obj['value']
      when 'Symbol'
        obj['value'].to_sym
      else

      end
    end
  end
end