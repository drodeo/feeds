class AddLastUpdateOnTimeToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :last_update_on_time, :integer, default: 0
  end
end
