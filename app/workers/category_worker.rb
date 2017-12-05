class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    @cats=Category.where(pages_count: 0).pluck(:id)
    @cats.each do |cat|
      Category.find(cat).delete if  Category.reset_counters(cat, :pages).nil?
    end
    cat1=Category.exists?('Без категории')
    @nocat=Page.where(category_id: nil)
    @nocat.update_all category_id: cat1.id
    Category.reset_counters(cat1.id, :pages)
  end
end