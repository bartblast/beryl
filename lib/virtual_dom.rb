require 'native'

class VirtualDOM
  def render(element, parentDom)
    document = Native(`window.document`)
    dom = element[:type] == 'text' ? document.createTextNode('') : document.createElement(element[:type])

    add_event_listeners(element, dom)
    set_attributes(element, dom)

    childElements = element[:children] || [];
    childElements.each { |child| render(child, dom) }

    replace_children(parentDom, dom)
  end

  private

  def add_event_listeners(element, dom)
    listener_props = element[:props].select { |key, _value| listener?(key) }
    listener_props.each do |key, value|
      event_type = key.downcase[2..-1]
      dom.addEventListener(event_type, value)
    end
  end

  def listener?(key)
    key.start_with?('on')
  end

  def replace_children(parent_dom, dom)
    while (parent_dom.firstChild) do
      parent_dom.removeChild(parent_dom.firstChild)
    end
    parent_dom.appendChild(dom)
  end

  def set_attributes(element, dom)
    attribute_props = element[:props].reject { |key, _value| listener?(key) }
    attribute_props.each { |key, value| dom[key] = value }
  end
end