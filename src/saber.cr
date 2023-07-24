require "json"
require "http/client"

class Saber
  class Unset
  end

  @@api_key : String?

  BASE_URL = URI.parse("https://admin.saber-trade.com")

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.api_key
    @@api_key
  end

  def self.client : HTTP::Client
    client = HTTP::Client.new(BASE_URL)

    client.not_nil!.before_request do |request|
      request.headers["Authorization"] = "Token #{@@api_key}"
      request.headers["Content-Type"] = "application/json"
    end

    client
  end
end

annotation EventPayload
end

require "./saber/**"
