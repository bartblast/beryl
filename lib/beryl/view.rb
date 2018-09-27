require 'beryl/virtual_dom'

module Beryl
  class View
    attr_accessor :state

    def div(props = {}, &children)
      node('div', props, children ? children.call : [])
    end

    def input(props = {}, &children)
      node('input', props, children ? children.call : [])
    end

    def link(text, props = {}, &children)
      node('a', props, [text(text)])
    end

    def node(type, props = {}, children)
      {
        type: type,
        props: props,
        children: children
      }
    end

    def span(props = {}, &children)
      node('span', props, children ? children.call : [])
    end

    def text(value, props = {}, &children)
      node('text', props.merge(nodeValue: value), children ? children.call : [])
    end
  end
end