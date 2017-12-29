class CategoryDeleteWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.where("pages_count <'100'").limit(100).pluck(:id)
    cat1=Category.where(name: 'Без категории').pluck(:id)
    cats.each do |cat|
      tmp= Category.find(cat)
      @pages=Page.where(category_id: tmp.id)
      @pages.update_all(category_id: cat1)
      tmp.delete
    end
    @pages=Page.where(category_id: nil).update_all(category_id: cat1)
    @pages=Page.where(category_id: 0).update_all(category_id: cat1)
  end
end