require 'beryl/message_handler'

class MessageHandler < Beryl::MessageHandler
  def handle(state, message, payload)
    case message

    when :IncrementClicked
      state.merge(counter: state[:counter] + 1, random: payload[:random])

    when :LoadClicked
      [state, :FetchData, key_1: 1, key_2: 2]

    when :LoadSuccess
      state.merge(content: payload[:data])

    end
  end
end