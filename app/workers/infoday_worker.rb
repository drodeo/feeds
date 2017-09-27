class InfodayWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!


  def perform
    @pages = Page.all.count
    @tags = ActsAsTaggableOn::Tag.all.count
    @taggings = ActsAsTaggableOn::Tagging.all.count
    @source = Feed.all.count
    info=Info.first || Info.new
    info.page_count=@pages
    info.tag_count=@tags
    info.tagging=@taggings
    info.size=@source
    info.save
  end
end