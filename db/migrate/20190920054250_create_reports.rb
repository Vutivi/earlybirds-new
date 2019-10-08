class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :trip, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :reason
      t.text :comment

      t.timestamps
    end
  end
end
