require 'rails_helper'

RSpec.describe "schedules/edit", type: :view do
  let(:schedule) {
    Schedule.create!(
      user_id: 1,
      recurrence: "MyString"
    )
  }

  before(:each) do
    assign(:schedule, schedule)
  end

  it "renders the edit schedule form" do
    render

    assert_select "form[action=?][method=?]", schedule_path(schedule), "post" do

      assert_select "input[name=?]", "schedule[user_id]"

      assert_select "input[name=?]", "schedule[recurrence]"
    end
  end
end
