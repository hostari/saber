require "../spec_helper"

describe Saber::Link do
  it "create a link" do
    WebMock.stub(:post, "https://admin.saber-trade.com/api/links/link/")
      .to_return(status: 200, body: File.read("spec/support/create_link.json"), headers: {"Content-Type" => "application/json"})

    link = Saber::Link.create(35, Saber::CreateAssetSize.from_json({
      assetType: "STOCK",
      symbol:    "META",
      size:      1,
    }))

    link.id.should eq(70)
  end

  it "retrieves a link" do
    WebMock.stub(:get, "https://admin.saber-trade.com/api/links/link/4f7cb")
      .to_return(status: 200, body: File.read("spec/support/create_link.json"), headers: {"Content-Type" => "application/json"})

    link = Saber::Link.retrieve("4f7cb")

    link.short_url.should eq("4f7cb")
  end
end
