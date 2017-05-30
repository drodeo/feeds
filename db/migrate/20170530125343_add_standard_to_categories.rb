class AddStandardToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :standard, :boolean
    add_column :categories, :parent, :integer, default: 0
    add_column :categories, :language, :string
    add_column :categories, :taggs, :string, default: ""
  end
end
