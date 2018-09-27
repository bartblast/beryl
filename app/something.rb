require 'beryl/widget'

class Something < Beryl::Widget
  def render(state)
    # row do
    #   text 'Bart 1'
    #   text 'Bart 2'
    # end
    text 'Bart'
  end
end