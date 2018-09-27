require 'beryl/widget'

class Something < Beryl::Widget
  def render(state)
    column :fill_width, :fill_height do
      text 'Bart', height: 100, width: 300
      text 'Abc', proportional_height: 2
      text 'Karol', :fill_height
      text 'Xyz', proportional_height: 3
    end
  end
end