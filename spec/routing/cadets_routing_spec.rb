require "rails_helper"

RSpec.describe CadetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cadets").to route_to("cadets#index")
    end

    it "routes to #new" do
      expect(get: "/cadets/new").to route_to("cadets#new")
    end

    it "routes to #show" do
      expect(get: "/cadets/1").to route_to("cadets#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/cadets/1/edit").to route_to("cadets#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/cadets").to route_to("cadets#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/cadets/1").to route_to("cadets#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cadets/1").to route_to("cadets#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/cadets/1").to route_to("cadets#destroy", id: "1")
    end
  end
end
