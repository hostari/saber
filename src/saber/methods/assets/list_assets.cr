class Saber::Asset
  def self.list : Array(Asset)
    response = Saber.client.get("/api/links/asset/")

    if response.status_code == 200
      Array(Asset).from_json(response.body)
    else
      raise Error.from_json(response.body, "error")
    end
  end
end
