Staff.create!([
  {is_admin: false, first_name: "John", last_name: "Doe", phone_number: "123-456-7890", email: "john.doe@tamu.edu", password: "jdoe123."},
  {is_admin: true, first_name: "Jane", last_name: "Doe", phone_number: "987-654-3210", email: "jane.doe@tamu.edu", password: "jdoe123!"}
])
Cadet.create!([
  {first_name: "Billy", last_name: "Bob", graduation_year: 2026, phone_number: "112-358-1321", uin: "123456789", password: nil},
  {first_name: "Ranger", last_name: "Rick", graduation_year: 2023, phone_number: "754-234-8237", uin: "637897446", password: nil},
  {first_name: "Jimmy", last_name: "Smith", graduation_year: 2024, phone_number: "345-346-5457", uin: "267489968", password: nil}
])
