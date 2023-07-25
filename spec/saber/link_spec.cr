require "../spec_helper"

describe Saber::Link do
  it "create a link" do
    WebMock.stub(:post, "https://admin.saber-trade.com/api/links/link/")
      .to_return(status: 201, body: File.read("spec/support/create_link.json"), headers: {"Content-Type" => "application/json"})

    assets = [
      {
        assetType: "STOCK",
        symbol:    "META",
        size:      0.01,
      },
      {
        assetType: "STOCK",
        symbol:    "ABNB",
        size:      0.01,
      },
      {
        assetType: "STOCK",
        symbol:    "A",
        size:      0.01,
      },
    ]

    a = assets.map { |asset| Saber::CreateAssetSize.from_json(asset) }

    link = Saber::Link.create(35, a)

    link.id.should eq(70)
    link.assets.size.should eq(3)
    link.assets.first.size.should eq(0.01)
  end

  it "retrieves a link" do
    WebMock.stub(:get, "https://admin.saber-trade.com/api/links/link/4f7cb/")
      .to_return(status: 200, body: File.read("spec/support/create_link.json"), headers: {"Content-Type" => "application/json"})

    link = Saber::Link.retrieve("4f7cb")

    link.short_url.should eq("4f7cb")
  end
end
