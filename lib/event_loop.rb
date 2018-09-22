require 'virtual_dom'

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
      @state = transition(@messages.shift)
      render
    end
  end

  def transition(message)
    case message.first
    when :ButtonClicked
      @state + 1
    end
  end
end