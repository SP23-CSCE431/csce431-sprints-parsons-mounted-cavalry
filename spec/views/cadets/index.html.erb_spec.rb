require 'rails_helper'

RSpec.describe "cadets/index", type: :view do
  before(:each) do
    assign(:cadets, [
      Cadet.create!(
        first_name: "First Name",
        last_name: "Last Name",
        graduation_year: 2,
        phone_number: "Phone Number",
        uin: "Uin",
        password: "Password"
      ),
      Cadet.create!(
        first_name: "First Name",
        last_name: "Last Name",
        graduation_year: 2,
        phone_number: "Phone Number",
        uin: "Uin",
        password: "Password"
      )
    ])
  end

  it "renders a list of cadets" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("First Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Last Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Uin".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Password".to_s), count: 2
  end
end
