class InfosController < ApplicationController
  require 'open-uri'
  require 'rubygems'
  require 'text'
  require 'time'
  require 'csv'

  def info
    @info=Info.first
    #@pages = Page.all.count
    #@tags = ActsAsTaggableOn::Tag.all.count
    #@taggings = ActsAsTaggableOn::Tagging.all.count
    #@source = Source.all.count
   # @s = Source.all
    #  @s.each do |source|
    #  pages_count = source.pages.all.count
    #  info=Info.new #if Info.find(source_id: source.id).nil?
    #  info.size=pages_count
    #  info.source_id=source.id
    #  info.save
    #  @pages = Page.uniq.pluck(:time)
    #  @pages.each do |p|
    #    puts p
    #  end
    # end
      # loa
    #TlgrmWorker.perform_async(25.minutes)
    #TagsWorker.perform_async(30.minutes)
    #PagematchWorker.perform_async(30.minutes)
  end

    def infoday

     @pages = Page.where.not(published: nil ).count
     @tags = ActsAsTaggableOn::Tag.where(taggings_count: !0).count
     @taggings = ActsAsTaggableOn::Tagging.where(taggable_type: "Page").count
     @source = Feed.count
     @info=Info.first || Info.new
     @info.page_count=@pages
     @info.tag_count=@tags
     @info.tagging=@taggings
     @info.size=@source
     @info.save
    end

  def infotoday
   @info=Info.first
   @source = Feed.all
   @source.each do |a|
    info=Info.find_by_source_id(a.id) || Info.new
    count=Page.where(source_id: a.id).count
    @pg=Page.where(source_id: a.id).pluck(:id)
    tagging_count=ActsAsTaggableOn::Tagging.where(taggable_id: @pg).count
    @tg=ActsAsTaggableOn::Tagging.select('distinct tag_id').where(taggable_id: @pg).count
    info.tag_count=@tg
    info.tagging=tagging_count
    info.source_id=a.id
    info.page_count=count
    info.save
  end
   @s = Source.includes(:infos)
  end

  def infoday1
    @info=Info.first
    @source = Feead.all
    @source.each do |a|
      info=Info.find_by_source_id(a.id) || Info.new
      count=Page.where(source_id: a.id).count
      @pg=Page.where(source_id: a.id).pluck(:id)
      tagging_count=ActsAsTaggableOn::Tagging.where(taggable_id: @pg).count
      @tg=ActsAsTaggableOn::Tagging.select('distinct tag_id').where(taggable_id: @pg).count
      info.tag_count=@tg
      info.tagging=tagging_count
      info.source_id=a.id
      info.page_count=count
      info.save
    end
     @source.each do |a|
       jdata=Page.where(source_id: a.id).order("published asc").first
       for i in (0..(Date.today-jdata.published.to_date).to_i) do
         info= Info.where(source_id: a.id, data: Date.today-i)
         info= Info.new if info.empty?
         #lo
         count=Page.where(source_id: a.id, published: ((Date.today-i).to_time.beginning_of_day..(Date.today-i).to_time.end_of_day)).count
         @tags = ActsAsTaggableOn::Tag.all.count
         @pg=Page.where(source_id: a.id, published: ((Date.today-i).to_time.beginning_of_day..(Date.today-i).to_time.end_of_day)).pluck(:id)
         tagging_count=ActsAsTaggableOn::Tagging.where(taggable_id: @pg).count
         info.tagging=tagging_count
         @tg=ActsAsTaggableOn::Tagging.select('distinct tag_id').where(taggable_id: @pg).count
         #tg1=@tg.distinct.count
         info.tag_count=@tg
         puts count
         info.source_id=a.id
         info.page_count=count
         info.data=Date.today-i
         #lo
         info.save
       end
     end

    @s = Source.includes(:infos)

  end
end
