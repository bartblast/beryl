require 'command_handler'
require 'json'
require 'serializer'

module Beryl
  class Backend
    def call(env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/command'
        [200, { 'Content-Type' => 'application/json; charset=utf-8' }, [handle_command(req)]]
      else
        [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [response]]
      end
    end

    private

    def handle_command(req)
      json = JSON.parse(req.body.read)
      result = CommandHandler.new.handle(json['type'].to_sym, json['payload'])
      Serializer.serialize(result)
    end

    def hydrate_state
      Serializer.serialize(eval(File.read('app/initial_state.rb'))).gsub('"', '&quot;')
    end

    def response
      <<~HEREDOC
      <!DOCTYPE html>
      <html>
        <head>
          <script src="build/app.js"></script>
          <link rel="stylesheet" type="text/css" href="build/style.css">
        </head>
        <body>
          <div id="beryl" data-beryl="#{hydrate_state}" class="bg-color-255-255-255-255 font-color-0-0-0-255 font-size-20 font-open-sanshelveticaverdanasans-serif s e ui s e"></div>
        </body>
      </html>
      HEREDOC
    end
  end
end