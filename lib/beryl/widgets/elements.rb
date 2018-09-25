require 'beryl/widgets/row_builder'

module Beryl
  module Widgets
    module Elements
      def initialize
        @elements = []
      end

      def row(*args, &block)
        @elements << Beryl::Widgets::RowBuilder.build(*args, &block)
      end

      def text(string, props = nil)
        @elements << {
          type: :text,
          value: string,
          props: props
        }
      end
    end
  end
end