require 'opal'
require 'native'
require 'serializer'
require 'virtual_dom'

puts 'Wow, running opal!'

def div(props = {}, &children)
  node('div', props, children ? children.call : [])
end

def input(props = {}, &children)
  node('input', props, children ? children.call : [])
end

def link(props = {}, &children)
  node('a', props, children ? children.call : [])
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

element = div(id: 'container') {[
  input(value: 'foo', type: 'text'),
  link(href: '/bar'),
  span() {[
    text('Foo')
  ]}
]}

def onload(&block)
  `window.onload = block;`
end

onload do
  document = Native(`window.document`)
  parentDom = document.getElementById('root')
  VirtualDOM.new.render(element, parentDom)
end