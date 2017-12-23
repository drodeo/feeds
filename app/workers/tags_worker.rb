require 'lingua/stemmer'
class TagsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker


  def perform
    puts "Work with tags"
    @pages = Page.left_joins(:taggings).where(taggings: {taggable_id: nil}).limit(1000)
    ActsAsTaggableOn.delimiter = [' ', ',']
    ttags=Tagexcept.pluck(:name)
    @pages.each do |p|
      p.tag_list.add(Lingua.stemmer(p.title.gsub(/[\d\,\.\?\!\:\;\"\-\']/, "").downcase.split(' ')-ttags,:language => "ru"), parse: true)
      p.save
    end
  end
end