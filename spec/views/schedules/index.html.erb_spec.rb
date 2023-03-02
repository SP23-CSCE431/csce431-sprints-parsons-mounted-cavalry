require 'rails_helper'

RSpec.describe "schedules/index", type: :view do
  before(:each) do
    assign(:schedules, [
      Schedule.create!(
        user_id: 2,
        recurrence: "Recurrence"
      ),
      Schedule.create!(
        user_id: 2,
        recurrence: "Recurrence"
      )
    ])
  end

  it "renders a list of schedules" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Recurrence".to_s), count: 2
  end
end
