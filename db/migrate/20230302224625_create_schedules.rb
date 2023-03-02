class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.string :recurrence

      t.timestamps
    end
  end
end
