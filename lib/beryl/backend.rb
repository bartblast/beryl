require 'json'
require 'command_handler'
require 'serializer'

module Beryl
  class Backend
    HTML = <<~HEREDOC
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

    def call (env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/rock/command'
        [200, { 'Content-Type' => 'application/json; charset=utf-8' }, [run_command(req)]]
      else
        [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [HTML]]
      end
    end

    def run_command(req)
      json = JSON.parse(req.body.read)
      result = CommandHandler.new.handle(json['type'].to_sym, json['payload'])
      Serializer.serialize(result)
    end
  end
end
