require 'rails_helper'

RSpec.describe "attendances/new", type: :view do
  before(:each) do
    assign(:attendance, Attendance.new(
      schedule_id: 1,
      horse_id: 1,
      purpose: "MyString"
    ))
  end

  it "renders new attendance form" do
    render

    assert_select "form[action=?][method=?]", attendances_path, "post" do

      assert_select "input[name=?]", "attendance[schedule_id]"

      assert_select "input[name=?]", "attendance[horse_id]"

      assert_select "input[name=?]", "attendance[purpose]"
    end
  end
end
