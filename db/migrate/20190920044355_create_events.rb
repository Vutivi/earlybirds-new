class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :address
      t.datetime :start_time
      t.datetime :end_time
      t.string :ticket_link
      t.boolean :expired, default: false
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
