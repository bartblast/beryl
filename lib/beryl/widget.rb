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
    end

    def row(*args, &block)
      @children << build(:row, *args, &block)
    end

    def text(string, props = nil)
      @children << {
        type: :text,
        value: string,
        props: props
      }
    end
  end
end