json.extract!(attendance, :id, :schedule_id, :horse_id, :date, :check_in_time, :purpose, :created_at, :updated_at)
json.url(attendance_url(attendance, format: :json))
