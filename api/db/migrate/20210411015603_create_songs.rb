class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.integer :min, null: false, default: 0
      t.integer :sec, null: false, default: 0
      t.integer :discography_id, null: false
      t.integer :track_number, null: false
      t.integer :producer_id
      t.integer :lyricist_id
      t.integer :composer_id
      t.integer :artist_id, null: false
      t.integer :vocalist_id
      t.integer :bassist_id
      t.integer :guitarist_id
      t.integer :drummer_id
      t.integer :keyboardist_id
      t.integer :genre_id
      t.integer :grammy_id

      t.timestamps
    end
  end
end
