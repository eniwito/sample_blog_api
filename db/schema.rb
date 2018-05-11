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

ActiveRecord::Schema.define(version: 2018_05_07_210013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ips", force: :cascade do |t|
    t.inet "ip"
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_ratings", force: :cascade do |t|
    t.bigint "post_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_ratings_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ip_id"
    t.string "title"
    t.text "body"
    t.decimal "avg_rating", precision: 7, scale: 5, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ratings_count", default: 0, null: false
    t.index ["ip_id"], name: "index_posts_on_ip_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
