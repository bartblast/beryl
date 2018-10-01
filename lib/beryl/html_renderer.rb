module Beryl
  class HTMLRenderer
    def render(element)
      return element[:props][:nodeValue] if element[:type] == 'text'
      "#{open_tag(element)}#{children(element)}#{close_tag(element)}"
    end

    private

    def children(element)
      element[:children].each_with_object('') do |child, html|
        html << render(child)
      end
    end

    def close_tag(element)
      "</#{element[:type]}>"
    end

    def open_tag(element)
      "<#{element[:type]}#{props(element[:props])}>"
    end

    def props(props)
      props.each_with_object('') do |(key, value), html|
        html << " #{key}=\"#{value}\""
      end
    end
  end
end