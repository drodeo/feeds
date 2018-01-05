class CategoryDeleteWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    cats=Category.where("pages_count <'100'").limit(100).pluck(:id)
    cat1=Category.where(name: 'Без категории').pluck(:id)
    cats.each do |cat|
      tmp= Category.find(cat)
      Page.where(category_id: tmp.id).update_all(category_id: cat1[0])
      tmp.delete
    end
    @pages=Page.where(category_id: nil).update_all(category_id: cat1[0])
  end
end