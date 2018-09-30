module Beryl
  module Routing
    module Matcher
      extend self

      DEFAULT_CONSTRAINT = '.*'

      def match(route, path)
        params = params(route)
        r = params.each_with_object("#{route.clone}") do |param, result|
          result.sub!(":#{param}", "(#{DEFAULT_CONSTRAINT})")
        end
        regex = /\A#{r}\z/
        matched = regex.match(path)
        return false unless matched
        params(route).each_with_object({}).with_index do |(param, result), index|
          result[param] = matched[index + 1]
        end

      end

      private

      def params(route)
        route.scan(/:[[:lower:]_]+[[:lower:][:digit:]_]*/).map { |param| param[1..-1].to_sym }
      end
    end
  end
end
