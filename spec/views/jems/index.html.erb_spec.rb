require 'spec_helper'

describe "jems/index" do
  before(:each) do
    assign(:jems, [
      stub_model(Jem,
        :name => "Name",
        :seq => 1,
        :comment => "Comment"
      ),
      stub_model(Jem,
        :name => "Name2",
        :seq => 1,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of jems" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
