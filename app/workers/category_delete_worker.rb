class CategoryDeleteWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.where("pages_count <'100'").limit(100).pluck(:id)
    cats.each do |cat|
      tmp= Category.find(cat)
      cat1=Category.where(name: 'Без категории')
      @pages=Page.where(category_id: tmp.id)
      @pages.update_all(category_id: cat1.first.id)
      Category(cat.id).delete
    end
  end
end