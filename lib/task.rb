class Task
  def initialize(&block)
    `setTimeout(function(){#{block.call}}, 0)`
  end
end