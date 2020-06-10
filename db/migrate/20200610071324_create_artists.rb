class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.integer :birth_year
      t.integer :birth_month
      t.integer :birth_day
      t.integer :gender, null: false
      t.string :country

      t.timestamps
    end
  end
end
