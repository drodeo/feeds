class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.where("pages_count >'100'").order(pages_count: :desc).limit(100).pluck(:id)
    cats.each do |cat|
      tmp=Category.where(id: cat)
      tmp.update_all(pages_count: Page.where(category_id: cat).count)
    end
  end
end