require 'beryl/backend'
require 'rack'

use Rack::Static, :urls => ['/build']
run Beryl::Backend.new