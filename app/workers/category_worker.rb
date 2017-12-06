class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    @cats=Category.where(pages_count: 0).limit(500).pluck(:id)
    @cats.each do |cat|
      tmp= Category.reset_counters(cat, :pages)
      Category.find(cat).delete if tmp.nil?
    end
    cat1=Category.exists?('Без категории')
    @nocat=Page.where(category_id: 0)
    @nocat.update_all category_id: cat1.id
    Category.reset_counters(cat1.id, :pages)
  end
end