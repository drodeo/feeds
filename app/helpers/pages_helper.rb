module PagesHelper

  def analyzerss
    @feed=[]
    @feedname=[] 
    @feedurl=[] 
    @source.rss.each do |a|
      url=a.url
      begin
        feed = Feedjira::Feed.fetch_and_parse url
      rescue Feedjira::FetchFailure => e
        Rails.logger.error e.message<<' '<< a.url
        puts a.url
        next
      rescue Feedjira::NoParserAvailable => e
        Rails.logger.error e.message<<' '<< a.url<<' '<< "no parser available"
        puts a.url, "no parser available"
        nexе
      rescue StandardError=>e
        Rails.logger.error e.message
        puts e.message
        next

      end
      @feedname << a.name
      @feedurl << a.url
      @feed <<   feed.entries.first.to_a
    #lo
    end
  end

  def cut_summary(str)
    str=strip_tags(str)
    str.size>400 ? str[0..400]+'...' :str
  end

  def render_view
    if request.variant == [:desktop]

    end
  end

end
