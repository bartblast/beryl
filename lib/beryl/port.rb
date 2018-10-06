require 'beryl/frontend'

module Beryl
  class Port

    def publish(message, payload)
      Beryl::Frontend.runtime.push([message, payload])
      Beryl::Frontend.runtime.process
    end
  end
end