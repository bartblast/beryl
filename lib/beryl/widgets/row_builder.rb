require 'beryl/widgets/elements'

module Beryl
  module Widgets
    class RowBuilder
      include Beryl::Widgets::Elements

      attr_reader :elements

      def self.build(*args, &block)
        builder = self.new
        builder.instance_eval(&block)
        {
          type: :row,
          props: args,
          elements: builder.elements
        }
      end
    end
  end
end