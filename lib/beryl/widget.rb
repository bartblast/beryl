require 'beryl/utils/constantizer'

module Beryl
  class Widget
    attr_reader :children

    def initialize
      @children = []
    end

    def build(type, *args, &block)
      element = Widget.new
      element.instance_eval(&block)
      {
        type: type,
        props: args,
        children: element.children
      }
    end

    def column(*args, &block)
      @children << build(:column, *args, &block)
      @children
    end

    def method_missing(name, *args, &block)
      constantized = Beryl::Utils::Constantizer.(name.to_s)
      child = args.any? ? constantized.new.render(*args) : constantized.new.render
      raise SyntaxError.new("Widget #{name} should return only one element (use row or column)") if child.is_a?(Array) && child.size > 1
      @children += child
      child
    rescue NoMethodError
      raise NameError.new("There is no such widget: #{name}")
    end

    def row(*args, &block)
      @children << build(:row, *args, &block)
      @children
    end

    def text(string, props = nil)
      @children << {
        type: :text,
        value: string,
        props: props
      }
      @children
    end
  end
end
