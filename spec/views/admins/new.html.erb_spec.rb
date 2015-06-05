require 'rails_helper'

RSpec.describe "admins/new", type: :view do
  before(:each) do
    assign(:admin, Admin.new(
      :username => "MyString",
      :password => "MyString"
    ))
  end

  it "renders new admin form" do
    render

    assert_select "form[action=?][method=?]", admins_path, "post" do

      assert_select "input#admin_username[name=?]", "admin[username]"

      assert_select "input#admin_password[name=?]", "admin[password]"
    end
  end
end
