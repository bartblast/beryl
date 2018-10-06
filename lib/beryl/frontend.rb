require 'opal'
require 'native'
require 'beryl/deserializer'
require 'beryl/frontend_runtime'
require 'beryl/port'

module Beryl
  module Frontend
    extend self

    attr_accessor :view, :message_handler
    attr_reader :runtime

    def onload(&block)
      `window.onload = block;`
    end

    def run
      onload do
        document = Native(`window.document`)
        root = document.getElementById('beryl')
        serialized_state = root.getAttribute('data-beryl').gsub('&quot;', '"')
        state = Beryl::Deserializer.deserialize(serialized_state)
        @runtime = Beryl::FrontendRuntime.new(root, state, @view, @message_handler)
        @runtime.run
        @runtime
      end
    end
  end
end