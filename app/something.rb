require 'beryl/widget'

class Something < Beryl::Widget
  def render(state)
    # row do
    #   text 'Bart'
    #   text 'Karol'
    # end
    # column do
    #   text 'Bart'
    #   text 'Karol'
    # end

    column :fill_width do
      text 'Bart'
    end
  end
end