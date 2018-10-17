require 'beryl/message_handler'

class MessageHandler < Beryl::MessageHandler
  def handle(state, message, payload)
    case message

    when :increment_clicked
      state.merge counter: state[:counter] + 1, random: payload[:random]

    when :LoadClicked
      [state, :FetchData, key_1: 1, key_2: 2]

    when :SendCommandToPort
      [state, :PortCommand, key_1: 111]

    when :LoadSuccess
      state.merge content: payload[:data]

    else
      [state]
    end
  end
end