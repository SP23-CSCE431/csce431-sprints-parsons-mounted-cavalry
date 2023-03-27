require "rails_helper"

RSpec.describe NavbarComponent, type: :component do

  it "Navbar rendered with a logout button" do
    render_inline(NavbarComponent.new())

    expect(rendered_component).to have_selector("nav.navbar")
    expect(rendered_component).to have_selector("button[data-bs-toggle='offcanvas'][data-bs-target='#sidebar']")
    expect(rendered_component).to have_selector("a.navbar-brand[href='/'][style='color: #dfad14;']", text: "Parsons Mounted Cavalry Attendance")
    expect(rendered_component).to have_selector("a[href='/'][class='btn btn-outline-danger'][role='button']", text: "Logout")
  end
end
