require 'rack'
require_relative 'lib/app'

use Rack::Static, :urls => ['/build']
run App.new