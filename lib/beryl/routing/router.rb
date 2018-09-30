require 'beryl/routing/matcher'

module Beryl
  module Routing
    class Router
      attr_reader :routes

      def initialize
        @routes = []
        draw
      end

      def match(path)
        @routes.each do |route|
          matched = Beryl::Routing::Matcher.match(route[0], path)
          return [route[1], matched] if matched
        end
        [:not_found]
      end

      private

      def draw
        eval(File.open(File.expand_path('./app/routes.rb')).read)
      end

      def route(path, route)
        @routes << [path, route]
      end
    end
  end
end