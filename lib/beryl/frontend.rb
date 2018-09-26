require 'opal'
require 'native'
require 'beryl/deserializer'
require 'beryl/runtime'

def onload(&block)
  `window.onload = block;`
end

onload do
  document = Native(`window.document`)
  root = document.getElementById('beryl')
  serialized_state = root.getAttribute('data-beryl').gsub('&quot;', '"')
  state = Beryl::Deserializer.deserialize(serialized_state)
  Beryl::Runtime.new(root, state).run
end