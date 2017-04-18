class AddEntryIdToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :entry_id, :string, default: ""
  end
end
