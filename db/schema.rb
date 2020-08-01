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

ActiveRecord::Schema.define(version: 2020_08_01_051207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_genres", force: :cascade do |t|
    t.integer "genre_id", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.integer "gender", null: false
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discographies", force: :cascade do |t|
    t.integer "type"
    t.string "title", null: false
    t.time "play_length", null: false
    t.string "label"
    t.text "explanation"
    t.date "sales_start_at"
    t.integer "grammy_id"
    t.integer "genre_id"
    t.integer "chart"
    t.integer "producer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.time "play_length", null: false
    t.integer "discography_id", null: false
    t.integer "producer_id"
    t.integer "lyricist_id"
    t.integer "composer_id"
    t.integer "artist_id", null: false
    t.integer "bassist_id"
    t.integer "guitarist_id"
    t.integer "drummer_id"
    t.integer "keyboardist_id"
    t.integer "genre_id"
    t.integer "grammy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
