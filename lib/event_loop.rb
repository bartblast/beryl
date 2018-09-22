require 'virtual_dom'
require 'task'
require 'bowser/http'
require 'serializer'

class EventLoop
  def initialize(root, state)
    @messages = []
    @root = root
    @state = state
  end

  def push(message)
    puts 'adding message...'
    @messages << message
  end

  def render
    VirtualDOM.new.render(self, element(@state), @root)
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

  def run_command(type, payload)
    puts 'running command'
    Task.new do
      Bowser::HTTP.fetch('/rock/command', method: :post, data: { type: type, payload: Serializer.serialize(payload) })
        .then(&:json) # JSONify the response
        .then { |response| puts response }
        .catch { |exception| warn exception.message }
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