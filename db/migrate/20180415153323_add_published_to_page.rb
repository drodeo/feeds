class AddPublishedToPage < ActiveRecord::Migration[5.0]
  def change
     add_index :pages, :published, order: {published: :desc}
  end
end
