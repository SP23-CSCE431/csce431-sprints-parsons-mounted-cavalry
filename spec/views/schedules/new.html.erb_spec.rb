require 'rails_helper'

RSpec.describe "schedules/new", type: :view do
  before(:each) do
    assign(:schedule, Schedule.new(
      assignee_id: nil,
      assigner_id: nil,
      recurrence: "MyString"
    ))
  end

  it "renders new schedule form" do
    render

    assert_select "form[action=?][method=?]", schedules_path, "post" do

      assert_select "input[name=?]", "schedule[assignee_id_id]"

      assert_select "input[name=?]", "schedule[assigner_id_id]"

      assert_select "input[name=?]", "schedule[recurrence]"
    end
  end
end
