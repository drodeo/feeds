class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string   "title"
      t.string   "url"
      t.datetime "published"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.integer  "feed_id",   default: 0
      t.string   "summary"
      t.integer  "category_id", default: 0
      t.string   "image"
      t.string   "taggs",  default: ""
      t.integer  "cnt_match", default: 0
      t.boolean  "flag_match", default: false
      t.boolean  "dupl", default: false
     end
    add_index "pages", ["url"], name: "index_pages_on_url", unique: true
  end
end
