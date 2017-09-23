class CategoryWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    @cats=Category.all
    @cats.each do |cat|
      cat.count=Page.where(category_id: cat.id).count
      cat.save
     # puts cat.name,cat.count
    end
    cat1=Category.exists?('Без категории')
    @nocat=Page.where(category_id: nil)
    @nocat.update_all category_id: cat1.id
    cat1.count=Page.where(category_id: cat1.id).count

    cat1.save

  end
end