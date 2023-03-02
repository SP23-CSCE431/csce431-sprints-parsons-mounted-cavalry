require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      is_admin: false,
      is_staff: false,
      first_name: "First Name",
      last_name: "Last Name",
      classification: "Classification",
      skill_level: "Skill Level",
      phone_number: "Phone Number",
      email: "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Classification/)
    expect(rendered).to match(/Skill Level/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Email/)
  end
end
