class CreateAttendance < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.integer :attendance_id
      t.integer :cadet_id
      t.integer :horse_id
      t.integer :staff_id
      t.datetime :appointment_time
      t.datetime :check_in_time
      t.datetime :check_out_time
      t.text :purpose

      t.timestamps
    end
  end
end
