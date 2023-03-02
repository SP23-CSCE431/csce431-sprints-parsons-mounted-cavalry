class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.integer :assignee_id
      t.string :recurrence

      t.timestamps
    end
  end
end
