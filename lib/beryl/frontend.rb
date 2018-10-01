require 'opal'
require 'native'
require 'beryl/deserializer'
require 'beryl/frontend_runtime'

module Beryl
  class Frontend
    def initialize(view)
      @view = view
    end

    def onload(&block)
      `window.onload = block;`
    end

    def run
      onload do
        document = Native(`window.document`)
        root = document.getElementById('beryl')
        serialized_state = root.getAttribute('data-beryl').gsub('&quot;', '"')
        state = Beryl::Deserializer.deserialize(serialized_state)
        Beryl::FrontendRuntime.new(root, state, @view).run
      end
    end
  end
end