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
end
