class CreateDictCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :dict_categories do |t|
      t.integer :category_id
      t.string :dict

      t.timestamps
    end
  end
end
