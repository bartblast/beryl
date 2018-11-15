require 'beryl/create_table_statement'

module Beryl
  class Migration
    attr_reader :statements

    def initialize
      @statements = []
    end

    def create_table(table, &block)
      create_table_statement = Beryl::CreateTableStatement.new(table)
      create_table_statement.instance_eval(&block)
      @statements << create_table_statement
    end
  end
end