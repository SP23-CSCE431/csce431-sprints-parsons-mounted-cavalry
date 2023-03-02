require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        is_admin: false,
        is_staff: false,
        first_name: "First Name",
        last_name: "Last Name",
        classification: "Classification",
        skill_level: "Skill Level",
        phone_number: "Phone Number",
        email: "Email"
      ),
      User.create!(
        is_admin: false,
        is_staff: false,
        first_name: "First Name",
        last_name: "Last Name",
        classification: "Classification",
        skill_level: "Skill Level",
        phone_number: "Phone Number",
        email: "Email"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Classification".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Skill Level".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
  end
end
