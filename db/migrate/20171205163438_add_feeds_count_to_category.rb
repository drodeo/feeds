class AddFeedsCountToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :feeds_count, :integer, default: 0
  end
end
