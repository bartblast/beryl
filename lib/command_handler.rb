require 'net/http'

class CommandHandler
  def handle(type, payload)
    case type
    when :FetchData
      uri = URI('https://www.onet.pl/')
      [:DataFetched, data: Net::HTTP.get(uri).force_encoding("UTF-8")]
    end
  end
end