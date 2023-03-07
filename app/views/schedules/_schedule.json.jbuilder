json.extract!(schedule, :id, :user_id, :recurrence, :created_at, :updated_at)
json.url(schedule_url(schedule, format: :json))
