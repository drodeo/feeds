require "feedjira"


class FetchFeed
  USER_AGENT = "Feedjira".freeze

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
      feed_modified(raw_feed)
    end

  #  FeedRepository.set_status(:green, @feed)
 # rescue => ex
  #  FeedRepository.set_status(:red, @feed)

    @logger.error "Something went wrong when parsing #{@feed.url}: #{ex}" if @logger
  end

  private

  def fetch_raw_feed
    begin
    @parser.fetch_and_parse(@feed.url)
      feed.fetch
    rescue Faraday::TimeoutError => e
      Rails.logger.error e.message
      next
    end
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
end
