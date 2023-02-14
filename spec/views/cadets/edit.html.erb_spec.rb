require 'rails_helper'

RSpec.describe "cadets/edit", type: :view do
  let(:cadet) {
    Cadet.create!(
      first_name: "MyString",
      last_name: "MyString",
      graduation_year: 1,
      phone_number: "MyString",
      uin: "MyString",
      password: "MyString"
    )
  }

  before(:each) do
    assign(:cadet, cadet)
  end

  it "renders the edit cadet form" do
    render

    assert_select "form[action=?][method=?]", cadet_path(cadet), "post" do

      assert_select "input[name=?]", "cadet[first_name]"

      assert_select "input[name=?]", "cadet[last_name]"

      assert_select "input[name=?]", "cadet[graduation_year]"

      assert_select "input[name=?]", "cadet[phone_number]"

      assert_select "input[name=?]", "cadet[uin]"

      assert_select "input[name=?]", "cadet[password]"
    end
  end
end
