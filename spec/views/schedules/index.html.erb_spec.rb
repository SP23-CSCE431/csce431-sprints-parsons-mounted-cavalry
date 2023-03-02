require 'rails_helper'

RSpec.describe "schedules/index", type: :view do
  before(:each) do
    assign(:schedules, [
      Schedule.create!(
        assignee_id: nil,
        assigner_id: nil,
        recurrence: "Recurrence"
      ),
      Schedule.create!(
        assignee_id: nil,
        assigner_id: nil,
        recurrence: "Recurrence"
      )
    ])
  end

  it "renders a list of schedules" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Recurrence".to_s), count: 2
  end
end
