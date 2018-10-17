require 'beryl/utils'

module Beryl
  class Widget
    attr_reader :children

    def initialize
      @children = []
    end

    def build(type, *args, &block)
      element = Widget.new
      element.instance_eval(&block)
      raise SyntaxError.new("Button can have only 1 child element (use row or column)") if type == :button && element.children.size > 1
      {
        type: type,
        props: args,
        children: element.children
      }
    end

    def button(*args, &block)
      @children << build(:button, *args, &block)
      @children
    end

    def column(*args, &block)
      @children << build(:column, *args, &block)
      @children
    end

    def method_missing(name, *args, &block)
      constantized = Beryl::Utils.constantize(name.to_s)
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

    def below(*args, &block)
      @children << build(:below, *args, &block)
      @children
    end

    def above(*args, &block)
      @children << build(:above, *args, &block)
      @children
    end

    def on_left(*args, &block)
      @children << build(:on_left, *args, &block)
      @children
    end

    def text(string, *props)
      @children << {
        type: :text,
        value: string,
        props: props
      }
      @children
    end
  end
end
