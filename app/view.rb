require 'beryl/view'
require 'something'

class View < Beryl::View
  def render
    Something.new.render(state)
  end
end
