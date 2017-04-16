module PagesHelper

  def analyzerss
    @feed=[]
    @feedname=[] 
    @feedurl=[] 
    @source.rss.each do |a|
      url=a.ref
      begin
        feed = Feedjira::Feed.fetch_and_parse url
      rescue Feedjira::FetchFailure => e
        Rails.logger.error e.message, a.ref
        puts a.ref
        next
      rescue Feedjira::NoParserAvailable => e
        Rails.logger.error e.message, a.ref, "no parser available"
        puts a.ref, "no parser available"
        nexе
      rescue StandardError=>e
        Rails.logger.error e.message
        puts e.message
        next

      end
      @feedname << a.name
      @feedurl << a.ref
      @feed <<   feed.entries.first.to_a
    #lo
    end
  end

end
