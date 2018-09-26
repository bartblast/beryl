require 'json'
require 'command_handler'
require 'serializer'

module Beryl
  class Backend
    RESPONSE = <<~HEREDOC
      <!DOCTYPE html>
      <html>
        <head>
          <script src='build/app.js'></script>
        </head>
        <body>
          <div id="root"></div>
        </body>
      </html>
    HEREDOC

    def call(env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/command'
        [200, { 'Content-Type' => 'application/json; charset=utf-8' }, [handle_command(req)]]
      else
        [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [RESPONSE]]
      end
    end

    def handle_command(req)
      json = JSON.parse(req.body.read)
      result = CommandHandler.new.handle(json['type'].to_sym, json['payload'])
      Serializer.serialize(result)
    end
  end
end
