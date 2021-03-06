require "fetch_feed"
require "story_repository"
require "find_new_stories"

class FetchingWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    puts "RSS load"
    puts Time.now
    feeds = Feed.rss
    feeds.each do |f|
      puts f.name
      feed = FetchFeed.new(f)
      feed.fetch
    end
  end

  #Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '*/25 * * * *', class: 'FetchingWorker') # execute at every 25 minutes, ex: 12:05, 12:10, 12:15...etc
end