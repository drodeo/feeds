class AddFeedIdsToChanns < ActiveRecord::Migration[5.0]
  def change
    add_column :channs, :feed_ids, :string
  end
end
