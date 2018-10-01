require 'json'

module Beryl
  module Deserializer
    extend self

    def deserialize(item, json = false)
      item = JSON.parse(item) unless json
      case item['class']
      when 'Hash'
        item['value'].each_with_object({}) do |(key, value), result|
          result[key.to_sym] = deserialize(value, true)
        end
      when 'Integer'
        item['value'].to_i
      when 'String'
        item['value']
      when 'Symbol'
        item['value'].to_sym
      end
    end
  end
end