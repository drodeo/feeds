
class StoryRepository
  #extend UrlHelpers

  def self.add(entry, feed)
   # entry.url = normalize_url(entry.url, feed.url)
    s2 = entry.categories[0] if defined? entry.categories
    cat1 = Category.exists?(s2)
    #cat2=Category.exists?('Без категории')
    cat1.name = s2 || "Без категории" if cat1.id==nil
    cat1.save if cat1.id.blank?
#binding.pry
    Page.create(feed_id: feed.id,
                 title: sanitize(entry.title),
                 url: entry.url,
                 image: entry.image,
                 summary: extract_content(entry),
                 published: entry.published || Time.now,
                 entry_id: entry.id,
                 category_id: cat1.id,
                 image: (entry.image if defined? entry.image))
   # lo
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

  def self.save(feed)
    feed.save
  end

  def self.exists?(id, feed_id)
    Page.exists?(id: id, feed_id: feed_id)
  end

  def self.feed(feed_id)
    Page.where("feed_id = ?", feed_id).order("published desc").includes(:feed)
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
