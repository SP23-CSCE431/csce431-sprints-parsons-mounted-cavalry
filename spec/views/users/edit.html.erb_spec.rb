require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      is_admin: false,
      is_staff: false,
      first_name: "MyString",
      last_name: "MyString",
      classification: "MyString",
      skill_level: "MyString",
      phone_number: "MyString",
      email: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[is_admin]"

      assert_select "input[name=?]", "user[is_staff]"

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[classification]"

      assert_select "input[name=?]", "user[skill_level]"

      assert_select "input[name=?]", "user[phone_number]"

      assert_select "input[name=?]", "user[email]"
    end
  end
end
