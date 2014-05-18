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
      get("/jems/1").should route_to("jems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/jems/1/edit").should route_to("jems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/jems").should route_to("jems#create")
    end

    it "routes to #update" do
      put("/jems/1").should route_to("jems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/jems/1").should route_to("jems#destroy", :id => "1")
    end

  end
end
