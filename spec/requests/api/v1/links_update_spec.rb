require "rails_helper"

describe "link#update" do
  context "with a valid title and url" do
    it "updates the database appropriately" do

      user_1 = User.create(email: "vido@test.com", password:"test")
      user_2 = User.create(email: "notvido@test.com", password:"test")

      link_1 = user_1.links.create!( title: "Google", url: "http://www.google.com")
      link_2 = user_2.links.create!( title: "Yahoo", url: "http://www.yahoo.com")

      patch api_v1_link_path id:link_2.id, payload: ({id: link_2.id, title: link_2.title, url: link_2.url, read: true}).to_json

      expect(response).to be_success

      json = JSON.parse(response.body, symbolize_names: true)

      updated_link = Link.find(link_2.id)
      expect(json[:id]).to eq(updated_link.id)
      expect(json[:title]).to eq(updated_link.title)
      expect(json[:url]).to eq(updated_link.url)
    end
  end
  context "with a invalid title" do
    it "it doesn't update the database and returns JSON" do

      user_1 = User.create(email: "vido@test.com", password:"test")
      user_2 = User.create(email: "notvido@test.com", password:"test")

      link_1 = user_1.links.create!( title: "Google", url: "http://www.google.com")
      link_2 = user_2.links.create!( title: "Yahoo", url: "http://www.yahoo.com")

      patch api_v1_link_path id:link_2.id, payload: ({id: link_2.id, title: "", url: link_2.url, read: true}).to_json

      expect(response).to be_success

      json = response.body

      expect(json).to eq("You need a title Bro!")
    end
  end
  context "with a invalid url" do
    it "it doesn't update the database and returns JSON" do

      user_1 = User.create(email: "vido@test.com", password:"test")
      user_2 = User.create(email: "notvido@test.com", password:"test")

      link_1 = user_1.links.create!( title: "Google", url: "http://www.google.com")
      link_2 = user_2.links.create!( title: "Yahoo", url: "http://www.yahoo.com")

      patch api_v1_link_path id:link_2.id, payload: ({id: link_2.id, title: link_2.title, url: "www.yahoo.com", read: true}).to_json

      expect(response).to be_success

      json = response.body

      expect(json).to eq("Invalid Url Bro!")
    end
  end
end
