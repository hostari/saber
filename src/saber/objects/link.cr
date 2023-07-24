@[EventPayload]
class Saber::Link
  include JSON::Serializable

  getter id : Int32

  @[JSON::Field(key: "linkType")]
  getter link_type : String

  @[JSON::Field(key: "articleUrl")]
  getter article_url : String
  getter title : String

  @[JSON::Field(key: "createdAt")]
  getter created_at : Time
  getter expired : Bool

  @[JSON::Field(key: "sabertradeShortUrl")]
  getter short_url : String

  class Creator
    include JSON::Serializable

    getter id : Int32
    @[JSON::Field(key: "firstName")]
    getter first_name : String
    @[JSON::Field(key: "lastName")]
    getter last_name : String
  end

  getter creator : Creator

  @[JSON::Field(key: "approvalStatus")]
  getter approval_status : String

  class Asset
    include JSON::Serializable

    module FloatConverter
      def self.from_json(value : JSON::PullParser) : Float64
        value.read_string.to_f
      end

      def self.to_json(value : Float64, json : JSON::Builder)
        json.string(value)
      end
    end

    getter id : Int32
    getter asset : Saber::Asset
    @[JSON::Field(key: "assetType")]
    getter asset_type : String
    @[JSON::Field(converter: Saber::Link::Asset::FloatConverter)]
    getter size : Float64

    getter expiry : Time?

    @[JSON::Field(key: "callPut")]
    getter call_put : String?

    @[JSON::Field(key: "strikePrice", converter: Saber::Link::Asset::FloatConverter)]
    getter strike_price : Float64?

    getter ticker : String

    class CurrentPrice
      include JSON::Serializable
      @[JSON::Field(converter: Saber::Link::Asset::FloatConverter)]
      getter close : Float64
    end

    @[JSON::Field(key: "currentPrice")]
    getter current_price : CurrentPrice
  end

  getter assets : Array(Asset)

  getter bets : Array(String)

  getter destination : String

  class Embed
    include JSON::Serializable
    include JSON::Serializable::Unmapped

    class Links
      include JSON::Serializable

      getter button : String
      getter iframe : String
      getter link : String
      getter url : String
    end

    @[JSON::Field(key: "allAssets")]
    getter all_assets : Links
  end

  getter embed : Embed
end
