require 'json'

module Beryl
  module Deserializer
    extend self

    def deserialize(value, json = false)
      value = JSON.parse(value) unless json
      case value['class']
      when 'Hash'
        value['value'].each_with_object({}) do |(key, value), result|
          result[key.to_sym] = deserialize(value, true)
        end
      when 'Integer'
        value['value'].to_i
      when 'String'
        value['value']
      end
    end
  end
end