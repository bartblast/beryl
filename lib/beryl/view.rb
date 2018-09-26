module Beryl
  class View
    def initialize(state)
      @state = state
    end

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

    def get_virtual_dom
      div(id: 'container') {[
        input(value: 'foo', type: 'text'),
        span() {[
          text(' Foo ' + @state[:counter].to_s + ' ')
        ]},
        link(' Increment ', onClick: [:IncrementClicked, key_1: 1, key_2: 2]),
        link(' Load ', onClick: [:LoadClicked, key_1: 1, key_2: 2]),
        div {[
          text(@state[:content])
        ]}
      ]}
    end
  end
end