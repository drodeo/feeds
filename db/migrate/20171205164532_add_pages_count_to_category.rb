class AddPagesCountToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :pages_count, :integer, default: 0
  end
end
