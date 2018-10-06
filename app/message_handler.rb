require 'beryl/message_handler'

class MessageHandler < Beryl::MessageHandler
  def handle(state, message, payload)
    case message

    when :IncrementClicked
      state.merge(counter: state[:counter] + 1, random: payload[:random])

    when :LoadClicked
      [state, :FetchData, key_1: 1, key_2: 2]

    when :SendCommandToPort
      [state, :SomePortMessage, :abc_port, key_1: 111]

    when :LoadSuccess
      state.merge(content: payload[:data])

    else
      [state]
    end
  end
end