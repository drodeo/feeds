
class StoryRepository
  #extend UrlHelpers

  def self.add(entry, feed)
   # entry.url = normalize_url(entry.url, feed.url)

    Page.create(feed_id: feed.id,
                 title: sanitize(entry.title),
                 url: entry.url,
                 image: entry.image,
                 summary: extract_content(entry),
                 published: entry.published || Time.now,
                 entry_id: entry.id)
    #lo
  end

  def self.fetch(id)
    Page.find(id)
  end

  def self.fetch_by_ids(ids)
    Page.where(id: ids)
  end

  def self.fetch_unread_by_timestamp(timestamp)
    timestamp = Time.at(timestamp.to_i)
    Page.where("pages.created_at < ?", timestamp)
  end

  def self.fetch_unread_by_timestamp_and_group(timestamp, group_id)
    fetch_unread_by_timestamp(timestamp).joins(:feed)
  end

  def self.fetch_unread_for_feed_by_timestamp(feed_id, timestamp)
    timestamp = Time.at(timestamp.to_i)
    Page.where(feed_id: feed_id).where("created_at < ? AND is_read = ?", timestamp, false)
  end

  def self.save(story)
    story.save
  end

  def self.exists?(id, feed_id)
    Page.exists?(id: id, feed_id: feed_id)
  end

  def self.unread
    Page.where(is_read: false).order("published desc").includes(:feed)
  end

  def self.unread_since_id(since_id)
    unread.where("id > ?", since_id)
  end

  def self.feed(feed_id)
    Page.where("feed_id = ?", feed_id).order("published desc").includes(:feed)
  end

  def self.read(page = 1)
    Page.where(is_read: true).includes(:feed)
         .order("published desc").page(page).per_page(20)
  end

  def self.starred(page = 1)
    Page.where(is_starred: true).includes(:feed)
         .order("published desc").page(page).per_page(20)
  end

  def self.all_starred
    Page.where(is_starred: true)
  end

  def self.unstarred_read_stories_older_than(num_days)
    Page.where(is_read: true, is_starred: false)
         .where("published <= ?", num_days.days.ago)
  end

  def self.read_count
    Page.where(is_read: true).count
  end

  def self.extract_content(entry)
    sanitized_content = ""

    if entry.content
      sanitized_content = sanitize(entry.content)
    elsif entry.summary
      sanitized_content = sanitize(entry.summary)
    end

   # expand_absolute_urls(sanitized_content, entry.url)
  end

  def self.sanitize(content)
    Loofah.fragment(content.gsub(/<wbr\s*>/i, ""))
          .scrub!(:prune)
          .scrub!(:unprintable)
          .to_s
  end


end
