require 'native'
require 'event_loop'

class VirtualDOM
  def render(event_loop, element, parentDom, replace = true)
    document = Native(`window.document`)
    dom = element[:type] == 'text' ? document.createTextNode('') : document.createElement(element[:type])

    add_event_listeners(element, dom, event_loop)
    set_attributes(element, dom)

    childElements = element[:children] || [];
    childElements.each { |child| render(event_loop, child, dom, false) }

    update_dom(parentDom, dom, replace)
  end

  private

  def add_event_listeners(element, dom, event_loop)
    listener_props = element[:props].select { |key, _value| listener?(key) }
    listener_props.each do |key, value|
      event_type = key.downcase[2..-1]
      dom.addEventListener(event_type, lambda { event_loop.push(value); event_loop.process })
    end
  end

  def listener?(key)
    key.start_with?('on')
  end

  def set_attributes(element, dom)
    attribute_props = element[:props].reject { |key, _value| listener?(key) }
    attribute_props.each { |key, value| dom[key] = value }
  end

  def update_dom(parent_dom, dom, replace)
    if replace
      while (parent_dom.firstChild) do
        parent_dom.removeChild(parent_dom.firstChild)
      end
    end
    parent_dom.appendChild(dom)
  end
end