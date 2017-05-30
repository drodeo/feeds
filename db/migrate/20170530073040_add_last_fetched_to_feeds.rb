class AddLastFetchedToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :last_fetched, :datetime
  end
end
