require 'beryl/view'
require 'widgets/homepage'
require 'widgets/page_x'
require 'widgets/not_found'

class View < Beryl::View
  def render
    case state[:route]
    when :homepage
      Homepage.new.render(state)
    when  :page_x
      PageX.new.render(state)
    else
      NotFound.new.render(state)
    end
  end
end
