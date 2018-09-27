require 'beryl/widget'

class Something < Beryl::Widget
  def render(state)

    row :fill_width do
      text 'Bart', width: 100
      text 'Abc', proportional_width: 2
      text 'Karol', :fill_width
      text 'Dupa', proportional_width: 3
    end
  end
end