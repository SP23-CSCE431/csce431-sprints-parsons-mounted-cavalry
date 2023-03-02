
  class CreateAttendance < ActiveRecord::Migration[7.0]
    def change
      create_table :attendances do |t|
        t.integer :schedule_id
        t.integer :horse_id
        t.datetime :check_in_time
        t.string :purpose

        t.timestamps
      end
    end
  end 

