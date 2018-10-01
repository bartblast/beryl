require 'command_handler'
require 'json'
require 'serializer'
require 'beryl/routing/router'
require 'beryl/html_renderer'
require 'beryl/backend_runtime'

module Beryl
  class Backend
    def initialize(view)
      @view = view
      initial_state = eval(File.read('app/initial_state.rb'))
      @state = initial_state.clone
    end

    def call(env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/command'
        [200, { 'Content-Type' => 'application/json; charset=utf-8' }, [handle_command(req)]]
      else
        router = Beryl::Routing::Router.new
        route = router.match(req.path_info)
        @state[:route] = route[0]
        @state[:params] = route[1]
        code = (route[0] != :not_found ? 200 : 404)
        [code, { 'Content-Type' => 'text/html; charset=utf-8' }, [response]]
      end
    end

    private

    def handle_command(req)
      json = JSON.parse(req.body.read)
      result = CommandHandler.new.handle(json['type'].to_sym, json['payload'])
      Serializer.serialize(result)
    end

    def hydrate_state
      Serializer.serialize(@state).gsub('"', '&quot;')
    end

    def render
      runtime = Beryl::BackendRuntime.new(@state, @view)
      runtime.process_all_messages
      @view.state = runtime.state
      virtual_dom = VirtualDOM.new(@view.render)
      HTMLRenderer.new.render(virtual_dom.dom.first)
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
          <div id="beryl" data-beryl="#{hydrate_state}" class="bg-color-255-255-255-255 font-color-0-0-0-255 font-size-20 font-open-sanshelveticaverdanasans-serif s e ui s e">#{render}</div>
        </body>
      </html>
      HEREDOC
    end
  end
end