class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.integer :feed_id
      t.datetime "data"
      t.integer  "size"
      t.integer  :page_count
      t.integer  :tag_count
      t.integer  :tagging

      t.timestamps null: false

    end
    add_index :infos, [:feed_id, :data], unique: true
  end
end
