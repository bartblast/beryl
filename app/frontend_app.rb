require 'opal'
require 'native'
require 'serializer'
require 'virtual_dom'

puts 'Wow, running opal!'

element = {
  type: 'div',
  props: { id: 'container' },
  children: [
    { type: 'input', props: { value: 'foo', type: 'text' } },
    { type: 'a', props: { href: '/bar' } },
    {
      type: 'span',
      props: {},
      children: [
        { type: 'text', props: { nodeValue: 'Foo' } }
      ]
    }
  ]
}

def onload(&block)
  `window.onload = block;`
end

onload do
  document = Native(`window.document`)
  parentDom = document.getElementById('root')
  VirtualDOM.new.render(element, parentDom)
end