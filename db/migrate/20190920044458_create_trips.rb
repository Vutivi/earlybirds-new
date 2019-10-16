class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :kind, default: 0
      t.string :start_location
      t.string :end_location
      t.text :description
      t.integer :seats
      t.integer :price
      t.references :vehicle, foreign_key: true
      t.references :plan, foreign_key: true
      t.boolean :approved, default: false
      t.datetime :departure_times
      t.datetime :return_times
      t.boolean :round_trip, default: false
      t.references :event, foreign_key: true, nullable: true
      t.references :user, foreign_key: true
      t.datetime :plan_expiry_date, nullable: false
      t.timestamps
    end
  end
end
