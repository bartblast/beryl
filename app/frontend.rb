require 'beryl/frontend'
require 'view'
require 'message_handler'

message_handler = MessageHandler.new
view = View.new
Beryl::Frontend.new(view, message_handler).run