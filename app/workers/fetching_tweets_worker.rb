require "fetch_feed"
require "story_repository"
require "find_new_stories"

class FetchingTweetsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    puts "RSS load"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    @tweets = client.user_timeline('rns_online', count: 100)
    feeds = Feed.tweets
    feeds.each do |f|
      @tweets = client.user_timeline(f.name, count: 100)
      # entry.url = normalize_url(entry.url, feed.url)
      @tweets.each do |tweet|
        entry=tweet.full_text.split('https')
        Page.create(feed_id: f.id,
                    title: entry[0],
                    url: "https"<<entry[1],
                    summary: '',
                    published: tweet.created_at || Time.now) if !tweet.text.blank?
      end
    end
  end

  #Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '*/25 * * * *', class: 'FetchingWorker') # execute at every 25 minutes, ex: 12:05, 12:10, 12:15...etc
end