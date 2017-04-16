class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string   "name"
      t.string   "url"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.string   "icon_file_name"
      t.string   "icon_content_type"
      t.integer  "icon_file_size"
      t.datetime "icon_updated_at"
      t.integer  "count"
      t.text     "type"
      t.boolean  "html"
      t.string   "source"
    end
  end
end

