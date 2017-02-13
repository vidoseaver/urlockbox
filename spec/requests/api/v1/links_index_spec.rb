require "rails_helper"

describe "link#index" do
  it "it returns json of all links" do
    user_1 = User.create(email: "vido@test.com", password:"test")
    user_2 = User.create(email: "notvido@test.com", password:"test")

    link_1 = user_1.links.create!( title: "Google", url: "http://www.google.com")
    link_2 = user_2.links.create!( title: "Yahoo", url: "http://www.yahoo.com")

    get api_v1_links_path

    expect(response).to be_success

    json = JSON.parse(response.body, symbolize_names: true)

    json_sorted = json.sort{|link| link[:id]}.reverse

    expect(json.count).to eq(Link.count)
    expect(json.first[:id]).to eq(link_1.id)
    expect(json.second[:id]).to eq(link_2.id)
    expect(json.first[:title]).to eq(link_1.title)
    expect(json.second[:title]).to eq(link_2.title)
    expect(json.first[:url]).to eq(link_1.url)
    expect(json.second[:url]).to eq(link_2.url)
  end
end
