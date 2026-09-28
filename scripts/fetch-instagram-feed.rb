#!/usr/bin/env ruby
require 'json'
require 'net/http'
require 'uri'

output = ARGV.fetch(0, '_data/instagram-feed.json')
access_token = ENV['INSTAGRAM_ACCESS_TOKEN']
abort 'INSTAGRAM_ACCESS_TOKEN must be configured as a repository Actions secret' if access_token.to_s.empty?
account_id = ENV['INSTAGRAM_USER_ID'].to_s
account_id = 'me' if account_id.empty?
query = URI.encode_www_form(
  fields: 'id,caption,media_type,media_url,permalink,thumbnail_url,timestamp',
  limit: 12,
  access_token: access_token
)
uri = URI("https://graph.instagram.com/#{account_id}/media?#{query}")
response = Net::HTTP.get_response(uri)

unless response.is_a?(Net::HTTPSuccess)
  abort "Instagram Graph API request failed (HTTP #{response.code}): #{response.body}"
end

payload = JSON.parse(response.body)
abort "Instagram Graph API returned an error: #{payload['error']['message']}" if payload['error']
abort 'Instagram Graph API response did not include media data' unless payload['data'].is_a?(Array)

File.write(output, JSON.pretty_generate('posts' => payload['data']) + "\n")
puts "Updated #{output} with #{payload['data'].size} Instagram posts."
