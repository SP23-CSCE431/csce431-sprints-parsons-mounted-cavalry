User.create!([
  {is_admin: false, is_staff: false, first_name: "John", last_name: "Doe", classification: "Sophomore", skill_level: "Beginner", phone_number: "5127400020", email: "JohnDoe@tamu.edu"},
  {is_admin: true, is_staff: false, first_name: "Jane", last_name: "Doe", classification: "Senior", skill_level: "Advanced", phone_number: "5127400020", email: "JaneDoe@tamu.edu"},
  {is_admin: false, is_staff: true, first_name: "Doe", last_name: "Jane", classification: "Junior", skill_level: "Intermediate", phone_number: "5127400020", email: "DoeJane@tamu.edu"},
  {is_admin: false, is_staff: false, first_name: "Martin", last_name: "Wnorowski", classification: "Senior", skill_level: "Advanced", phone_number: "5127400020", email: "martin.wnorowski@tamu.edu"}
])
Schedule.create!([
  {user_id: 7, recurrence: "TR"},
  {user_id: 4, recurrence: "MWF"},
  {user_id: 6, recurrence: "TR"}
])
Horse.create!([
  {name: "Horsey", brand: "H1149", herd: "Alpha", difficulty: "Intermediate", condition: "Healthy"},
  {name: "Ed", brand: "J9822", herd: "Bravo", difficulty: "Advanced", condition: "Healthy"},
  {name: "Speedy", brand: "S711", herd: "Charlie", difficulty: "Intermediate", condition: "Healthy"},
  {name: "Clint", brand: "C4", herd: "Delta", difficulty: "Easy", condition: "Healthy"},
  {name: "Eddy", brand: "E5923", herd: "OOS", difficulty: "Easy", condition: "Healthy"}
])
Attendance.create!([
  