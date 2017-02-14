require 'rails_helper'

RSpec.describe Link, type: :model do
  context "valid_url?" do
    it "returns true if a link is valid" do
      link = "http://www.google.com"
      expect(Link.valid_url?(link)).to eq true
    end
    it "returns false if a link is invalid" do
      link = "www.google"
      expect(Link.valid_url?(link)).to eq false
    end
  end
  context "top_ten_read_in_last_24_hours" do
    it "top_ten_read_in_last_24_hours" do
      user = User.create(email: "user@test.com", password:"test")
      user2 = User.create(email: "user2@test.com", password:"test")

      user2.links.create!(title:"website5",  url:"https://www.website5.com", read: true)
      user2.links.create!(title:"website5",  url:"https://www.website5.com", read: true)
      user2.links.create!(title:"website6",  url:"https://www.website6.com", read: true)
      user2.links.create!(title:"website6",  url:"https://www.website6.com", read: false)
      user2.links.create!(title:"website6",  url:"https://www.website6.com", read: false)
      user2.links.create!(title:"website6",  url:"https://www.website6.com", read: false)
      user2.links.create!(title:"website6",  url:"https://www.website6.com", read: false)


      count = 0
      10.times do
        count += 1
        user.links.create!(title:"website#{count.to_s}",  url:"https://www.website#{count.to_s}.com", read: true)
      end

      top_ten = Link.top_ten_read_in_last_24_hours

      expect(Link.top_ten_read_in_last_24_hours.count).to eq(10)
      expect(top_ten.first[:url]).to eq("https://www.website5.com")
      expect(top_ten.second[:url]).to eq("https://www.website6.com")
    end
  end
end
