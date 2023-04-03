User.create!(
    [
        {
            is_admin: true,
            is_staff: false,
            first_name: "John",
            last_name: "Doe",
            classification: "Senior",
            skill_level: "Advanced",
            phone_number: "435-675-4345",
            email: "john.doe@tamu.edu"
        },
        {
            is_admin: false,
            is_staff: true,
            first_name: "Jane",
            last_name: "Doe",
            classification: "Senior",
            skill_level: "Intermediate",
            phone_number: "435-675-4345",
            email: "jane.doe@tamu.edu"
        },
        {
            is_admin: false,
            is_staff: false,
            first_name: "Billy",
            last_name: "Bob",
            classification: "Sophomore",
            skill_level: "Beginner",
            phone_number: "435-675-4345",
            email: "billy.bob@tamu.edu"
        },
        {
            is_admin: true,
            is_staff: false,
            first_name: "Zach",
            last_name: "Thygesen",
            classification: "Junior",
            skill_level: "Advanced",
            phone_number: "435-675-4345",
            email: "zthygesen@tamu.edu"
        }
    ]
)
Horse.create!(
    [
        { name: "Horsey", brand: "H1149", herd: "Bravo", difficulty: "Intermediate", condition: "Healthy" },
        { name: "Ed", brand: "J9822", herd: "Delta", difficulty: "Advanced", condition: "Healthy" },
        { name: "Speedy", brand: "S711", herd: "Bravo", difficulty: "Easy", condition: "Healthy" }
    ]
)
