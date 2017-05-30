class ChangeColumnParentFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :parent, :integer
    add_column :categories, :parent_id, :integer, default: 0
  end
end
