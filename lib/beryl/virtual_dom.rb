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
          width = width(element[:props])
          klass = "hc s c #{width[:class]} ct cl"
          props = { class: klass, style: width[:style] }
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :row
          width = width(element[:props])
          klass = "hc s r #{width[:class]} cl ccy"
          props = { class: klass, style: width[:style] }
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :text
          width = width(element[:props])
          klass = "hc s e #{width[:class]}"
          props = { class: klass, style: width[:style] }
          dom << node('div', props, [node('text', { nodeValue: element[:value] })])
        end
      end
    end

    def width(props)
      type = width_type(props)
      {
        type: type,
        class: width_class(type),
        style: width_style(props, type)
      }
    end

    def width_type(props)
      return :content unless props
      return :fill if props.include?(:fill_width)
      hash = props.select { |p| p.is_a?(Hash) }.first
      # puts "HASH: #{hash}"
      return :fixed if hash[:width].is_a?(Integer)
      return :proportional if hash[:proportional_width].is_a?(Integer)
      :content
    end


    def width_class(type)
      case type
      when :content
        'wc'
      when :fill
        'wf'
      when :fixed
        ''
      when :proportional
        'wfp'
      end
    end

    def width_style(props, type)
      case type
      when :content
        ''
      when :fill
        ''
      when :fixed
        width = props.select { |p| p.is_a?(Hash) }.first[:width]
        "width: #{width}px;"
      when :proportional
        portion = props.select { |p| p.is_a?(Hash) }.first[:proportional_width]
        "flex-grow: #{100000 * portion};"
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
