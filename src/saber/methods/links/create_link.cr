class Saber::Link
  def self.create(
    creator : Int32,
    assets : Array(CreateAssetSize),
    title : String? = nil,
    expires_at : String? = nil,
    article_url : String? = nil,
    organization : Int32? = nil,
    destination : String? = nil
  ) : Link
    io = IO::Memory.new
    assets = assets.map(&.to_n_tuple)

    JSON.build(io) do |json|
      json.object do
        {% for x in %w(creator assets title expires_at article_url organization destination) %}
          if {{x.id}}.nil?
            # do nothing
          elsif {{x.id}}.is_a?(Array)
            json.field {{x}}.camelcase(lower: true) do
              json.array do
                {{x.id}}.each do |el|
                  json.raw(el.to_json)
                end
              end
            end
          else
            json.field {{x}}.camelcase(lower: true), {{x.id}}
          end
        {% end %}
      end
    end

    response = Saber.client.post("/api/links/link/", body: io.to_s)

    if response.status_code == 201
      Link.from_json(response.body)
    else
      raise Exception.new(response.body) 
    end
  end
end
