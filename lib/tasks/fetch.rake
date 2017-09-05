require 'rubygems'
require 'open-uri'
require 'text'
require 'time'
require 'csv'
require 'telegram/bot'
require 'matrix'
# require 'dop'
require 'set'
require 'uri'
require 'nokogiri'
require 'lingua/stemmer'
require_relative "../../app/services/feeds/fetch_feed"
require_relative "../../app/services/feeds/story_repository"
require_relative "../../app/services/feeds/find_new_stories"
#require 'bugsnag'

task fetch: :environment do
  puts "RSS load"
  feeds = Feed.order("created_at DESC")
  feeds.each do |f|
    feed = FetchFeed.new(f)
    feed.fetch
  end

end