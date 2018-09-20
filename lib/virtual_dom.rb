require 'native'

class VirtualDOM
  def render(element, parentDom)
    document = Native(`window.document`)
    dom = document.createElement(element[:type])
    childElements = element[:props][:children] || [];
    childElements.each { |child| render(child, dom) }
    parentDom.appendChild(dom)
  end
end