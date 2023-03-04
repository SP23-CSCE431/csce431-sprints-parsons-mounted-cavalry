require 'rails_helper'

RSpec.describe "attendances/index", type: :view do
  before(:each) do
    assign(:attendances, [
      Attendance.create!(
        schedule_id: 2,
        horse_id: 3,
        purpose: "Purpose"
      ),
      Attendance.create!(
        schedule_id: 2,
        horse_id: 3,
        purpose: "Purpose"
      )
    ])
  end

  it "renders a list of attendances" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Purpose".to_s), count: 2
  end
end
