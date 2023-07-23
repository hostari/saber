require "../spec_helper"

describe Saber::Asset do
  it "list assets" do
    WebMock.stub(:get, "https://admin.saber-trade.com/api/links/asset/")
      .to_return(status: 200, body: File.read("spec/support/list_assets.json"), headers: {"Content-Type" => "application/json"})

    assets = Saber::Asset.list

    assets.size.should eq(6)
  end
end
