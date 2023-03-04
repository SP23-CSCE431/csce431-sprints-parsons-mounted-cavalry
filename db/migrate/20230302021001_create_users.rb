class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.boolean :is_admin
      t.boolean :is_staff
      t.string :first_name
      t.string :last_name
      t.string :classification
      t.string :skill_level
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
