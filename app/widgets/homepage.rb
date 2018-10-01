require 'beryl/widget'

class Homepage < Beryl::Widget
  def render(state)
    column :fill_width, :fill_height do
      row :fill_width do
        column proportional_width: 2 do
          text 'ROW 1 COL 1'
        end
        column :fill_width do
          text 'ROW 1 COL 2'
        end
        column proportional_width: 2 do
          text 'ROW 1 COL 3'
        end
      end
      row :fill_width do
        column width: 200 do
          text 'ROW 2 COL 1'
        end
        column :fill_width, height: 50 do
          text 'ROW 2 COL 2'
        end
        column width: 300 do
          text 'ROW 2 COL 3'
        end
      end
      row :fill_width do
        column :fill_width do
          text 'ROW 3 COL 1'
        end
        column width: 400 do
          text 'ROW 3 COL 2'
        end
        column :fill_width do
          text 'ROW 3 COL 3'
        end
      end
    end
  end
end