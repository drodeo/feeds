class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.where("pages_count > '?'", 100).order(pages_count: :desc).limit(100)
    cats.each do |cat|
      Category.where(id: cat).update(pages_count: Page.where(category_id: cat).count, updated_at: Time.now) if cat.updated_at > Time.now+4
    end
  end
end