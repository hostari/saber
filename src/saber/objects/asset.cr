@[EventPayload]
class Saber::Asset
  include JSON::Serializable

  getter symbol : String
  getter name : String
  @[JSON::Field(key: "assetType")]
  getter asset_type : String
end

class Saber::CreateAssetSize
  include JSON::Serializable

  @[JSON::Field(key: "assetType")]
  getter asset_type : String
  @[JSON::Field(converter: Saber::Link::Asset::FloatConverter)]
  getter size : Float64
  getter expiry : Time?

  def self.from_json(value : NamedTuple | Hash(String, String))
    from_json(value.to_json)
  end

  def to_n_tuple
    {
      asset_type: asset_type,
      size:       size,
      expiry:     expiry,
    }
  end
end
