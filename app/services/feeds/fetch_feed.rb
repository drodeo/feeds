require "feedjira"


class FetchFeed
  USER_AGENT = "Feedjira".freeze
  MAX_RETRIES = 3

  def initialize(feed, parser: Feedjira::Feed, logger: nil)
    @feed = feed
    @parser = parser
    @logger = logger
  end

  def fetch
    raw_feed = fetch_raw_feed

    if raw_feed == 304
      feed_not_modified
    else
      feed_modified(raw_feed) if !@logger
    end
    #@logger.error "Something went wrong when parsing #{@feed.url}: #{@logger}" if @logger
  end

  private

  def fetch_raw_feed
    #retry_exceptions do
      begin
        @parser.fetch_and_parse(@feed.url)
        rescue Net::OpenTimeout, Net::ReadTimeout, Timeout::Error => e
          Rails.logger.error e.message+" "+@feed.url
          @logger=e.message
        rescue Faraday::TimeoutError => e
          Rails.logger.error e.message+" "+@feed.url
          @logger=e.message
        rescue Faraday::ConnectionFailed => e
          Rails.logger.error e.message+" "+@feed.url
          @logger=e.message
      end
    #end
  end


  
  
  
  

  def feed_not_modified
    @logger.info "#{@feed.url} has not been modified since last fetch" if @logger
  end

  def feed_modified(raw_feed)
    new_entries_from(raw_feed).each do |entry|
      StoryRepository.add(entry, @feed)
    end

    FeedRepository.update_last_fetched(@feed, raw_feed.last_modified)
  end

  def new_entries_from(raw_feed)

    finder = FindNewStories.new(raw_feed, @feed.id, @feed.last_update_on_time, latest_entry_id)
    finder.new_stories
    #binding.pry
  end


  def latest_entry_id
    return @feed.pages.order('published DESC').first.entry_id unless @feed.pages.empty?
  end

  def retry_exceptions
    retries = MAX_RETRIES
    begin
      yield
    rescue Feedjira::ConnectionTimeout
      retries -= 1
      retry unless retries.zero?
      raise
    end
  end
end
