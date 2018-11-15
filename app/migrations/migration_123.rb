require 'beryl/migration'

class Migration123 < Beryl::Migration
  def change
    create_table :users do
      column :first_name, String
    end
    # rename_table :users, :users_2
    create_table :orders do
      column :abc, Integer, :optional, :index, reference: :user, column: :id
      column :xyz, Float
    end
  end
end