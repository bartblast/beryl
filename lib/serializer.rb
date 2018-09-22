require 'json'

module Serializer
  extend self

  def serialize(obj, json = true)
    result = obj.is_a?(Array) ? array(obj) : item(obj)
    json ? result.to_json : result
  end

  private

  def array(obj)
    obj.each_with_object([]) { |item, result| result << serialize(item, false) }
  end

  def hash(obj)
    obj.each_with_object({}) { |(k, v), result| result[k] = serialize(v, false) }
  end

  def item(obj)
    { class: obj.class.to_s, value: value(obj) }
  end

  def properties(obj)
    obj.instance_variables.each_with_object({}) do |var, result|
      result[var] = serialize(obj.instance_variable_get(var), false)
    end
  end

  def value(obj)
    return obj.to_s if %w(Float Integer Number String Symbol).include?(obj.class.to_s)
    return hash(obj) if obj.is_a?(Hash)
    properties(obj)
  end
end
