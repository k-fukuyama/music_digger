# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_11_020355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_genres", force: :cascade do |t|
    t.integer "genre_id", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.integer "gender"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discographies", force: :cascade do |t|
    t.integer "discography_type"
    t.string "title", null: false
    t.string "play_length", default: "0", null: false
    t.string "label"
    t.text "explanation"
    t.date "sales_start_at"
    t.integer "artist_id", null: false
    t.integer "grammy_id"
    t.integer "genre_id"
    t.integer "chart"
    t.integer "producer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grammies", force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "song_id"
    t.integer "album_id"
    t.integer "year"
    t.integer "genre_id"
    t.integer "grammy_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.integer "min", default: 0, null: false
    t.integer "sec", default: 0, null: false
    t.integer "discography_id", null: false
    t.integer "track_number", null: false
    t.integer "producer_id"
    t.integer "lyricist_id"
    t.integer "composer_id"
    t.integer "artist_id", null: false
    t.integer "vocalist_id"
    t.integer "bassist_id"
    t.integer "guitarist_id"
    t.integer "drummer_id"
    t.integer "keyboardist_id"
    t.integer "genre_id"
    t.integer "grammy_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
