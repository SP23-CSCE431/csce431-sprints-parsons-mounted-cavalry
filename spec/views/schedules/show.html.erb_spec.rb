require 'rails_helper'

RSpec.describe "schedules/show", type: :view do
  before(:each) do
    assign(:schedule, Schedule.create!(
      user_id: 2,
      recurrence: "Recurrence"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Recurrence/)
  end
end
