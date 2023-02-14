class CreateCadets < ActiveRecord::Migration[7.0]
  def change
    create_table :cadets do |t|
      t.string :first_name
      t.string :last_name
      t.integer :graduation_year
      t.string :phone_number
      t.string :uin
      t.string :password

      t.timestamps
    end
  end
end
