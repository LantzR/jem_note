require 'spec_helper'

describe "jems/show" do
  before(:each) do
    @jem = assign(:jem, stub_model(Jem,
      :name => "Name",
      :seq => 1,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Comment/)
  end
end
