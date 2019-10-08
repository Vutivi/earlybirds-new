class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.references :user, foreign_key: true
      t.string :licence_plate, unique: true
      t.string :color
      t.integer :is_verified, default: 0

      t.timestamps
    end
  end
end
