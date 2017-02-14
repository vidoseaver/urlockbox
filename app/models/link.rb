require "uri"
class Link < ApplicationRecord
  belongs_to :user

  def self.valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil? ? true : false
  end

  def self.top_ten_read_in_last_24_hours
    links = Link.where(read: true)
    .where(updated_at: (Time.now - 24.hours)..Time.now)
    grouped = links.group_by{|link| link.url}
    grouped.values.map {|similiar_links| similiar_links.first}.take(10) 
  end
end
