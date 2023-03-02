require 'rails_helper'

RSpec.describe "schedules/new", type: :view do
  before(:each) do
    assign(:schedule, Schedule.new(
      user_id: 1,
      recurrence: "MyString"
    ))
  end

  it "renders new schedule form" do
    render

    assert_select "form[action=?][method=?]", schedules_path, "post" do

      assert_select "input[name=?]", "schedule[user_id]"

      assert_select "input[name=?]", "schedule[recurrence]"
    end
  end
end
