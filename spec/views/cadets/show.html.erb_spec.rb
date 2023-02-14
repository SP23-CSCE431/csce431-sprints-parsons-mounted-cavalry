require 'rails_helper'

RSpec.describe "cadets/show", type: :view do
  before(:each) do
    assign(:cadet, Cadet.create!(
      first_name: "First Name",
      last_name: "Last Name",
      graduation_year: 2,
      phone_number: "Phone Number",
      uin: "Uin",
      password: "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Uin/)
    expect(rendered).to match(/Password/)
  end
end
