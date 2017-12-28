class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.where("pages_count >'100'").order(pages_count: :asc).limit(100).pluck(:id)
    cats.each do |cat|
      tmp= Category.reset_counters(cat, :pages)
    end

    feeds=Feed.limit(500).pluck(:id)
    feeds.each do |feed|
     Feed.reset_counters(feed, :pages)
    end
  end
end