require 'beryl/widget'
require 'securerandom'

class Homepage < Beryl::Widget
  def render(state)
    column :fill_width, :fill_height do
      row :fill_width do
        column proportional_width: 2 do
          button on_click: [:increment_clicked, random: SecureRandom.uuid] do
            row do
              text 'Click'
              text ' me!'
            end
          end
        end
        column :fill_width do
          text "ROW 1 COL 2 (counter = #{state[:counter]})"
        end
        column proportional_width: 2 do
          text 'ROW 1 COL 3', border_width: 2, border_color: [0, 255, 0]
        end
        text 'some text below', :below
      end
      row :fill_width do
        column width: 200 do
          text 'ROW 2 COL 1'
        end
        column :fill_width, height: 50 do
          text "ROW 2 COL 2 (random = #{state[:random]})"
        end
        column width: 300 do
          text 'ROW 2 COL 3'
        end
      end
      row :fill_width, height: 200, background: [255, 0, 0] do
        column :fill_width do
          text 'ROW 3 COL 1'
        end
        column width: 400 do
          text 'ROW 3 COL 2'
          on_left do
            column :fill_height, background: [120, 120, 0] do
              text 'text 1'
              text 'text 2'
            end
          end
        end
        column :fill_width do
          text 'ROW 3 COL 3'
        end
        below do
          text 'below', background: [0, 0, 255]
        end
        above do
          text 'above', background: [0, 255, 0]
        end
      end
    end
  end
end