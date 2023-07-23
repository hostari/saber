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
    return @@client.not_nil! unless @@client.nil?

    self.reset_client

    @@client.not_nil!
  end

  def self.reset_client
    @@client = HTTP::Client.new(BASE_URL)

    @@client.not_nil!.before_request do |request|
      request.headers["Authorization"] = "Token #{@@api_key}"
      request.headers["Content-Type"] = "application/json"
    end
  end
end

annotation EventPayload
end

require "./saber/**"
