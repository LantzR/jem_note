require 'spec_helper'

describe "jems/edit" do
  before(:each) do
    @jem = assign(:jem, stub_model(Jem,
      :name => "MyString",
      :seq => 1,
      :comment => "MyString"
    ))
  end

  it "renders the edit jem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", jem_path(@jem), "post" do
      assert_select "input#jem_name[name=?]", "jem[name]"
      assert_select "input#jem_seq[name=?]", "jem[seq]"
      assert_select "input#jem_comment[name=?]", "jem[comment]"
    end
  end
end
