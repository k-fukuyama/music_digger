class CreateDiscographies < ActiveRecord::Migration[5.2]
  def change
    create_table :discographies do |t|
      t.integer :type
      t.string :title, null: false
      t.time :play_length, null: false
      t.string :label
      t.text :explanation
      t.date :sales_start_at
      t.integer :grammy_id
      t.integer :genre_id
      t.integer :chart
      t.integer :producer_id

      t.timestamps
    end
  end
end
