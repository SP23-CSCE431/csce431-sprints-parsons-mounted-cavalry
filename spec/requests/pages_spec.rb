require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /cadets_staffs" do
    it "returns http success" do
      get "/pages/cadets_staffs"
      expect(response).to have_http_status(:success)
    end
  end

end
