class AddAhoyIdToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :ahoy_visit_id, :bigint
  end
end
