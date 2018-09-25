module Beryl
  class VirtualDOM
    attr_reader :dom

    def initialize(layout)
      @layout = layout
      @dom = convert(layout)
    end

    private

    def convert(layout)
      layout.each_with_object([]) do |element, dom|
        case element[:type]
        when :column
          props = { style: 'display: flex' }
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :row
          props = { style: 'display: flex' }
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :text
          dom << node('span', {}, [node('text', { nodeValue: element[:value] })])
        end
      end
    end

    def node(type, props = {}, children = [])
      {
        type: type,
        props: props,
        children: children
      }
    end
  end
end
