require 'rails_helper'

RSpec.describe "cadets/new", type: :view do
  before(:each) do
    assign(:cadet, Cadet.new(
      first_name: "MyString",
      last_name: "MyString",
      graduation_year: 1,
      phone_number: "MyString",
      uin: "MyString",
      password: "MyString"
    ))
  end

  it "renders new cadet form" do
    render

    assert_select "form[action=?][method=?]", cadets_path, "post" do

      assert_select "input[name=?]", "cadet[first_name]"

      assert_select "input[name=?]", "cadet[last_name]"

      assert_select "input[name=?]", "cadet[graduation_year]"

      assert_select "input[name=?]", "cadet[phone_number]"

      assert_select "input[name=?]", "cadet[uin]"

      assert_select "input[name=?]", "cadet[password]"
    end
  end
end
