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
    @parser.fetch_and_parse(@feed.url)
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
    finder = FindNewStories.new(raw_feed, @feed.id, @feed.last_fetched, latest_entry_id)
    finder.new_stories
  end

  def options
    {
      user_agent: USER_AGENT,
      if_modified_since: @feed.last_update_on_time,
      timeout: 30,
      max_redirects: 2,
      compress: true
    }
  end

  def latest_entry_id
    return @feed.pages.first.entry_id unless @feed.pages.empty?
  end
end
