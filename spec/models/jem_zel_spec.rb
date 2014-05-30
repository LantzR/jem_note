require 'spec_helper'

  # - - - - - - - - - - - - - - - - - - - - - -
  # - Stead from jems_controller_spec
  #let(:valid_attributes) { { "name" => "rails" } }


describe Jem do
  
  describe "in creating a new Jem" do
    it "- expect to have a jem name" do
      pending " - Jem Model rspec #{__FILE__}"
      jem = Jem.create! valid_attributes
      assigns(:jems).should eq([jem])
    end
    it "- expect to have a unique jem name" do
      pending " - Jem Model rspec #{__FILE__}"
    end
    it "- allow to have a only a jem name" 
  end
end

# == Schema Information
#
# Table name: jems
#
#  name       :string(255)      not null, primary key
#  seq        :integer
#  comment    :string(40)
#  created_at :datetime
#  updated_at :datetime
#
