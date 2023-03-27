json.extract!(
    user,
    :id,
    :is_admin,
    :is_staff,
    :first_name,
    :last_name,
    :classification,
    :skill_level,
    :phone_number,
    :email,
    :created_at,
    :updated_at
)
json.url(user_url(user, format: :json))
