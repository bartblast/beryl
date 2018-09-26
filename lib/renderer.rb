require 'native'
require 'beryl/runtime'

class Renderer
  def render(runtime, element, parentDom, replace = true)
    document = Native(`window.document`)
    dom = element[:type] == 'text' ? document.createTextNode('') : document.createElement(element[:type])

    add_event_listeners(element, dom, runtime)
    set_attributes(element, dom)

    childElements = element[:children] || [];
    childElements.each { |child| render(runtime, child, dom, false) }

    update_dom(parentDom, dom, replace)
  end

  private

  def add_event_listeners(element, dom, runtime)
    listeners = element[:props].select { |key, _value| listener?(key) }
    listeners.each do |key, value|
      event_type = key.downcase[2..-1]
      dom.addEventListener(event_type, lambda { runtime.push(value); runtime.process })
    end
  end

  def listener?(key)
    key.start_with?('on')
  end

  def set_attributes(element, dom)
    attributes = element[:props].reject { |key, _value| listener?(key) }
    attributes.each { |key, value| dom[key] = value }
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