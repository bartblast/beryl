require 'beryl/utils'

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
        listeners = listeners(element[:props])
        width = width(element[:props])
        height = height(element[:props])
        style = "#{width[:style]}#{height[:style]}"
        case element[:type]
        when :button
          klass = "#{height[:class]} s e #{width[:class]}"
          props = { class: klass, style: style }
          props.merge!(listeners)
          dom << node('button', props, element[:children] ? convert(element[:children]) : [])
        when :column
          klass = "#{height[:class]} s c #{width[:class]} ct cl"
          props = { class: klass, style: style }
          props.merge!(listeners)
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :row
          klass = "#{height[:class]} s r #{width[:class]} cl ccy"
          props = { class: klass, style: style }
          props.merge!(listeners)
          dom << node('div', props, element[:children] ? convert(element[:children]) : [])
        when :text
          klass = "#{height[:class]} s e #{width[:class]}"
          props = { class: klass, style: style }
          props.merge!(listeners)
          dom << node('div', props, [node('text', { nodeValue: element[:value] })])
        end
      end
    end

    def listeners(props)
      hash_params = props.select { |prop| prop.is_a?(Hash) }.first
      return {} unless hash_params
      hash_params.select { |key, _value| key.to_s.start_with?('on')}.each_with_object({}) do |(key, value), result|
        result[Beryl::Utils.camelize(key.to_s, false)] = value
      end
    end

    def height(props)
      type = height_type(props)
      {
        type: type,
        class: height_class(type),
        style: height_style(props, type)
      }
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
      props = [props] unless props.is_a?(Array)
      return :content unless props
      return :fill if props.include?(:fill_width)
      hash = props.select { |p| p.is_a?(Hash) }.first
      return :content unless hash
      return :fixed if hash[:width].is_a?(Integer)
      return :proportional if hash[:proportional_width].is_a?(Integer)
      :content
    end

    def height_type(props)
      props = [props] unless props.is_a?(Array)
      return :content unless props
      return :fill if props.include?(:fill_height)
      hash = props.select { |p| p.is_a?(Hash) }.first
      return :content unless hash
      return :fixed if hash[:height].is_a?(Integer)
      return :proportional if hash[:proportional_height].is_a?(Integer)
      :content
    end

    def width_class(type)
      case type
      when :content
        'wc'
      when :fill
        'wf'
      when :fixed
        'we'
      when :proportional
        'wfp'
      end
    end

    def height_class(type)
      case type
      when :content
        'hc'
      when :fill
        'hf'
      when :fixed
        ''
      when :proportional
        'hfp'
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

    def height_style(props, type)
      case type
      when :content
        ''
      when :fill
        ''
      when :fixed
        height = props.select { |p| p.is_a?(Hash) }.first[:height]
        "height: #{height}px;"
      when :proportional
        portion = props.select { |p| p.is_a?(Hash) }.first[:proportional_height]
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
