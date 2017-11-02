# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171031183243) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "standard"
    t.string   "language"
    t.string   "taggs",      default: ""
    t.integer  "parent_id",  default: 0
  end

  create_table "channs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "feed_id"
    t.boolean  "email_notification"
    t.integer  "email_period"
    t.boolean  "tgram_notification"
    t.integer  "tgram_period"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.integer  "count"
    t.text     "type"
    t.boolean  "html"
    t.string   "source"
    t.integer  "last_update_on_time", default: 0
    t.datetime "last_fetched"
    t.boolean  "standard"
    t.integer  "parent",              default: 0
    t.string   "language"
    t.string   "taggs",               default: ""
    t.boolean  "twitter",             default: false
  end

  create_table "infos", force: :cascade do |t|
    t.integer  "feed_id"
    t.datetime "data"
    t.integer  "size"
    t.integer  "page_count"
    t.integer  "tag_count"
    t.integer  "tagging"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id", "data"], name: "index_infos_on_feed_id_and_data", unique: true, using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "published"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "feed_id",     default: 0
    t.string   "summary"
    t.integer  "category_id", default: 0
    t.string   "image"
    t.string   "taggs",       default: ""
    t.integer  "cnt_match",   default: 0
    t.boolean  "flag_match",  default: false
    t.boolean  "dupl",        default: false
    t.string   "entry_id",    default: ""
    t.index ["url"], name: "index_pages_on_url", unique: true, using: :btree
  end

  create_table "tagexcepts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tagexcepts_on_name", unique: true, using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tagoverlaps", force: :cascade do |t|
    t.string   "name"
    t.string   "nametarget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tagoverlaps_on_name", unique: true, using: :btree
    t.index ["nametarget"], name: "index_tagoverlaps_on_nametarget", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
