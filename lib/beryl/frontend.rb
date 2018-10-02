require 'opal'
require 'native'
require 'beryl/deserializer'
require 'beryl/frontend_runtime'

module Beryl
  class Frontend
    def initialize(view, message_handler)
      @view = view
      @message_handler = message_handler
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
        puts "STATE = #{state.inspect}"
        Beryl::FrontendRuntime.new(root, state, @view, @message_handler).run
      end
    end
  end
end