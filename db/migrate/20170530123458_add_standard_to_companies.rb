class AddStandardToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :standard, :boolean
    add_column :feeds, :parent, :integer, default: 0
    add_column :feeds, :language, :string
    add_column :feeds, :taggs, :string, default: ""
  end
end
