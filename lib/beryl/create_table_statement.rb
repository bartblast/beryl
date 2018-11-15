module Beryl
  class CreateTableStatement
    def initialize(table)
      @columns = []
      @table = table
    end

    def column(name, type, *args)
      @columns << { name: name, type: type, args: args }
    end
  end
end