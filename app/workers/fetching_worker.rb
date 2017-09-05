class FetchingWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform(count)
    puts "RSS load"
    feeds = Feed.order("created_at DESC")
    feeds.each do |f|
      feed = FetchFeed.new(f)
      feed.fetch
    end
  end
end