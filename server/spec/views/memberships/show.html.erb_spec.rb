require 'spec_helper'

describe "config/models/show" do
  before(:each) do
    @config_model = assign(:config_model, stub_model(Membership,
      :organisation => "Organisation",
      :membership_number => "Membership Number",
      :state => "State",
      :country => "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Organisation/)
    rendered.should match(/Membership Number/)
    rendered.should match(/State/)
    rendered.should match(/Country/)
  end
end