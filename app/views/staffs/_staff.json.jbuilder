json.extract! staff, :id, :is_admin, :first_name, :last_name, :phone_number, :email, :password, :created_at, :updated_at
json.url staff_url(staff, format: :json)
