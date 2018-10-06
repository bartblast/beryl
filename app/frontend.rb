require 'beryl/frontend'
require 'view'
require 'message_handler'

Beryl::Frontend.view = View.new
Beryl::Frontend.message_handler = MessageHandler.new
Beryl::Frontend.run
