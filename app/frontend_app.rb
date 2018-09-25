require 'opal'
require 'native'
require 'event_loop'
require 'serializer'
require 'renderer'
require 'beryl/widget'

puts 'Wow, running opal!'

class LogInPage < Beryl::Widget

end

p = LogInPage.new

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

class Interval
  def initialize(time = 0, &block)
    @interval = `setInterval(function(){#{block.call}}, time)`
  end

  def stop
    `clearInterval(#@interval)`
  end
end

onload do
  document = Native(`window.document`)
  parentDom = document.getElementById('root')

  state = { counter: 0, content: 'here we will load something' }
  event_loop = EventLoop.new(parentDom, state)
  event_loop.process
  event_loop.render
end