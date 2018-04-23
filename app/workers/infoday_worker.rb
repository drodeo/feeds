class InfodayWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    @pages = Page.where.not(published: nil ).count
    @tags = ActsAsTaggableOn::Tag.where.not(name: nil).count
    @taggings = ActsAsTaggableOn::Tagging.where(taggable_type: "Page").count
    @source = Feed.count
    info=Info.first || Info.new
    info.page_count=@pages
    info.tag_count=@tags
    info.tagging=@taggings
    info.size=@source
    info.save
  end
end