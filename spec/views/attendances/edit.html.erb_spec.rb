require 'rails_helper'

RSpec.describe "attendances/edit", type: :view do
  let(:attendance) {
    Attendance.create!(
      schedule_id: 1,
      horse_id: 1,
      purpose: "MyString"
    )
  }

  before(:each) do
    assign(:attendance, attendance)
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(attendance), "post" do

      assert_select "input[name=?]", "attendance[schedule_id]"

      assert_select "input[name=?]", "attendance[horse_id]"

      assert_select "input[name=?]", "attendance[purpose]"
    end
  end
end
