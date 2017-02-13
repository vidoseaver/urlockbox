require "uri"
class Link < ApplicationRecord
  belongs_to :user

  def self.valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil? ? true : false
  end

end
