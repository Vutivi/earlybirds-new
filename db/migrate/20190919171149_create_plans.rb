class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name, unique: true
      t.integer :price, unique: true
      t.integer :daily_price
      t.integer :length
      t.string :catch_phrase, unique: true
      t.text :description, unique: true
      t.json :perks

      t.timestamps
    end
  end
end
