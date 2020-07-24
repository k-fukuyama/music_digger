class CreateArtistGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_genres do |t|
      t.integer :genre_id, null: false
      t.integer :artist_id, null: false

      t.timestamps
    end
  end
end
