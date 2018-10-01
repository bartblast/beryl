require 'renderer'
require 'task'
require 'bowser/http'
require 'serializer'

module Beryl
  class FrontendRuntime
    attr_reader :state

    def initialize(root, state, view)
      @messages = []
      @root = root
      @state = state
      @view = view
      @commands = []
    end

    def push(message)
      @messages << message
    end

    def render
      @view.state = @state
      virtual_dom = VirtualDOM.new(@view.render)
      Renderer.new.render(self, virtual_dom.dom.first, @root)
    end

    def process
      while @messages.any?
        message = @messages.shift
        result = transition(message.first, message.last)
        @state = result.is_a?(Array) ? result.first : result
        command = result.is_a?(Array) ? result[1] : nil
        run_command(result[1], result[2]) if command
        render
      end
    end

    def process_all_messages
      while @messages.any?
        message = @messages.shift
        result = transition(message.first, message.last)
        @state = result.is_a?(Array) ? result.first : result
        command = result.is_a?(Array) ? result[1] : nil
        run_command(result[1], result[2]) if command
        if @commands.any?
          while @commands.any? do end # TODO: refactor
          process_all_messages
        end
      end
    end

    def run
      process
      render
    end

    def run_command(type, payload)
      uuid = SecureRandom.uuid
      @commands << uuid
      Task.new do
        Bowser::HTTP.fetch('/command', method: :post, data: { type: type, payload: Serializer.serialize(payload) })
          .then(&:json) # JSONify the response
          .then { |response| puts response; @commands.delete(uuid) }
          .catch { |exception| warn exception.message; @commands.delete(uuid)  }
      end
    end

    def transition(type, payload)
      case type

      when :IncrementClicked
        @state.merge(counter: @state[:counter] + 1)

      when :LoadClicked
        [@state, :FetchData, key_1: 1, key_2: 2]

      when :LoadSuccess
        @state.merge(content: payload[:data])

      end
    end
  end
end