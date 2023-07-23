class Saber::Link
  def self.create(
    creator : Int32,
    assets : CreateAssetSize,
    title : String? = nil,
    expires_at : String? = nil,
    article_url : String? = nil,
    organization : Int32? = nil,
    destination : String? = nil
  ) : Link
    io = IO::Memory.new
    builder = ParamsBuilder.new(io)
    assets = assets.to_n_tuple

    {% for x in %w(creator assets title expires_at article_url organization destination) %}
      # TODO: convert key to camelcase
      builder.add({{x}}, {{x.id}}) unless {{x.id}}.nil?
    {% end %}

    response = Saber.client.post("/api/links/link/", form: io.to_s)

    if response.status_code == 200
      Link.from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
