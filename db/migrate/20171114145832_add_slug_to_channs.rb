class AddSlugToChanns < ActiveRecord::Migration[5.0]
  def change
    add_column :channs, :slug, :string
  end
end
