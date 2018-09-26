require 'opal'
require 'native'
require 'event_loop'
require 'serializer'
require 'renderer'
require 'beryl/deserializer'
require 'beryl/utils'
require 'beryl/widget'

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

def onload(&block)
  `window.onload = block;`
end

def element(state)
  div(id: 'container') {[
    input(value: 'foo', type: 'text'),
    span() {[
      text(' Foo ' + state[:counter].to_s + ' ')
    ]},
    link(' Increment ', onClick: [:IncrementClicked, key_1: 1, key_2: 2]),
    link(' Load ', onClick: [:LoadClicked, key_1: 1, key_2: 2]),
    div {[
      text(state[:content])
    ]}
  ]}
end

onload do
  document = Native(`window.document`)
  root = document.getElementById('beryl')
  data = root.getAttribute('data-beryl').gsub('&quot;', '"')
  state = Beryl::Deserializer.deserialize(data)
  event_loop = EventLoop.new(root, state)
  event_loop.process
  event_loop.render
end