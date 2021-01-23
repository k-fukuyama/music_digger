class CreateGrammies < ActiveRecord::Migration[5.2]
  def change
    create_table :grammies do |t|
      t.integer :artist_id, null: false
      t.integer :song_id
      t.integer :album_id
      t.integer :year
      t.integer :genre_id
      t.integer :grammy_type

      t.timestamps
    end
  end
end
