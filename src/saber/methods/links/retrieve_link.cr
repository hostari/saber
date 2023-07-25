class Saber::Link
  def self.retrieve(short_url : String) : Link
    response = Saber.client.get("/api/links/link/#{short_url}/")

    if response.status_code == 200
      Link.from_json(response.body)
    else
      raise Exception.new(response.body)
    end
  end
end
