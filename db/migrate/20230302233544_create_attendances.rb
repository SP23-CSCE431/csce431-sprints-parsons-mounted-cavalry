class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.integer :schedule_id
      t.integer :horse_id
      t.date :date
      t.timestamp :check_in_time
      t.string :purpose

      t.timestamps
    end
  end
end
