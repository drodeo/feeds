class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    @cats=Category.where(pages_count: 0).limit(500).pluck(:id)
    @cats.each do |cat|
      if  Category.reset_counters(cat, :pages).nil?
        Category.find(cat).delete

      end
    end
    cat1=Category.exists?('Без категории')
    @nocat=Page.where(category_id: 0)
    @nocat.update_all category_id: cat1.id
    Category.reset_counters(cat1.id, :pages)
  end
end