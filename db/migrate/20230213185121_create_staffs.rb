class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.boolean :is_admin
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
