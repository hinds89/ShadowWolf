require 'spec_helper'

describe "config/projects/new" do
  before(:each) do
    assign(:config_project, stub_model(Project,
      :project_number => "MyString"
    ).as_new_record)
  end

  it "renders new config_project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "input#config_project_project_number[name=?]", "config_project[project_number]"
    end
  end
end
