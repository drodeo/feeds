class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.order(pages_count: :asc).limit(500).pluck(:id)
    cats.each do |cat|
      tmp= Category.reset_counters(cat, :pages)
    end
    cat1=Category.exists?('Без категории')
    nocat=Page.where(category_id: 0)
    nocat.update_all category_id: cat1.id

    feeds=Feed.limit(500).pluck(:id)
    feeds.each do |feed|
      Feed.reset_counters(feed, :pages)
    end
  end
end