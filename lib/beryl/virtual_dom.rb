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
          width = 'wc'
          width = 'wf' if element[:props] && element[:props].include?(:fill_width)
          klass = "hc s c #{width} ct cl"
          props = { class: klass }
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :row
          width = 'wc'
          width = 'wf' if element[:props] && element[:props].include?(:fill_width)
          klass = "hc s r #{width} cl ccy"
          props = { class: klass }
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :text
          width = 'wc'
          width = 'wf' if element[:props] && element[:props].include?(:fill_width)
          klass = "hc s e #{width}"
          props = { class: klass }
          dom << node('div', props, [node('text', { nodeValue: element[:value] })])
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
