module Beryl
  class BackendRuntime
    attr_reader :state

    def initialize(state, view, message_handler)
      @messages = []
      @state = state
      @view = view
      @commands = []
      @message_handler = message_handler
    end

    def push(message)
      @messages << message
    end

    def process_all_messages
      while @messages.any?
        message = @messages.shift
        result = @message_handler.handle(@state, message.first, message.last)
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
      puts 'running command'
    end
  end
end