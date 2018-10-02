app_path = File.expand_path('../app', __FILE__)
$LOAD_PATH.unshift(app_path) unless $LOAD_PATH.include?(app_path)

require 'beryl/backend'
require 'rack'
require 'view'
require 'message_handler'

view = View.new
message_handler = MessageHandler.new

use Rack::Static, :urls => ['/build']
run Beryl::Backend.new(view, message_handler)
