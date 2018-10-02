require 'json'
require 'beryl/utils'

module Beryl
  module Deserializer
    extend self

    def deserialize(obj, json = true)
      obj = JSON.parse(obj) if json
      obj.is_a?(Array) ? array(obj) : item(obj)
    end

    private

    def array(obj)
      obj.each_with_object([]) { |item, result| result << deserialize(item, false) }
    end

    def composite(obj)
      instance = Beryl::Utils.constantize(obj['class']).allocate
      obj['value'].each do |key, value|
        instance.instance_variable_set(key, deserialize(value, false))
      end
      instance
    end

    def item(obj)
      case obj['class']
      when 'Float'
        obj['value'].to_f
      when 'Hash'
        obj['value'].each_with_object({}) do |(key, value), result|
          result[key.to_sym] = deserialize(value, false)
        end
      when 'Integer'
        obj['value'].to_i
      when 'String'
        obj['value']
      when 'Symbol'
        obj['value'].to_sym
      else
        composite(obj)
      end
    end
  end
end