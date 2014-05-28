require "spec_helper"

describe JemsController do
  describe "routing" do

    it "routes to #index" do
      get("/jems").should route_to("jems#index")
    end

    it "routes to #new" do
      get("/jems/new").should route_to("jems#new")
    end

    it "routes to #show" do
      get("/jems/rails").should route_to("jems#show", :name => "rails")
    end

    it "routes to #edit" do
      get("/jems/rails/edit").should route_to("jems#edit", :name => "rails")
    end

    it "routes to #create" do
      post("/jems").should route_to("jems#create")
    end

    it "routes to #update" do
      put("/jems/rails").should route_to("jems#update", :name => "rails")
    end

    it "routes to #destroy" do
      delete("/jems/rails").should route_to("jems#destroy", :name => "rails")
    end

  end
end
