class AddPagesCountToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :pages_count, :integer, default: 0
  end
end
