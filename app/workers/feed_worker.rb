class FeedWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    feeds=Feed.all
    feeds.each do |feed|
      Feed.where(id: feed).update_all(pages_count: Page.where(feed_id: feed).count, updated_at: Time.now) if feed.updated_at < Time.now+4
    end
  end
end