class AddIndexToCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :parent
  end
end
