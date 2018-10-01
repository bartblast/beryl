require 'beryl/widget'

class PageX < Beryl::Widget
  def render(state)
    text "Other route: #{state[:route]}"
  end
end