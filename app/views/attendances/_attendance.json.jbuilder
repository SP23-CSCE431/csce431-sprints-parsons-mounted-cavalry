json.extract! attendance, :id, :attendance_id, :cadet_id, :horse_id, :staff_id, :appointment_time, :check_in_time, :check_out_time, :purpose, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
