require 'opal'
require 'rack'


app = Proc.new do |_env|
  ['200', { 'Content-Type' => 'text/html' }, [html]]
end

Rack::Handler::WEBrick.run app