class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.references :trip, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :cellphone
      t.string :email

      t.timestamps
    end
  end
end
