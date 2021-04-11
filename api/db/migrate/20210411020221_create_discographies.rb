class CreateDiscographies < ActiveRecord::Migration[6.0]
  def change
    create_table :discographies do |t|
      t.integer :discography_type
      t.string :title, null: false
      t.string :play_length, null: false, default: 0
      t.string :label
      t.text :explanation
      t.date :sales_start_at
      t.integer :artist_id, null: false
      t.integer :grammy_id
      t.integer :genre_id
      t.integer :chart
      t.integer :producer_id

      t.timestamps
    end
  end
end
