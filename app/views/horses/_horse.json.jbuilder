json.extract!(horse, :id, :name, :brand, :birthday, :created_at, :updated_at)
json.url(horse_url(horse, format: :json))
