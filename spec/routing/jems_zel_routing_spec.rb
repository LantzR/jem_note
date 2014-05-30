require "spec_helper"

describe JemsController do
  describe "routing" do

  # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
  #  == Generated RSpecs suporting routes ==
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  #  - Change to support pKey of name
  #  - Chg rails to aJemName
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   it "routes to #index" do
      get("/jems").should route_to("jems#index")
    end

    it "routes to #new" do
      get("/jems/new").should route_to("jems#new")
    end

    it "routes to #show" do
      get("/jems/aJemName").should route_to("jems#show", :name => "aJemName")
    end

    it "routes to #edit" do
      get("/jems/aJemName/edit").should route_to("jems#edit", :name => "aJemName")
    end

    it "routes to #create" do
      post("/jems").should route_to("jems#create")
    end

    it "routes to #update" do
      put("/jems/aJemName").should route_to("jems#update", :name => "aJemName")
    end

    it "routes to #destroy" do
      delete("/jems/aJemName").should route_to("jems#destroy", :name => "aJemName")
    end

  end
end
