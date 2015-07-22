require 'rails_helper'

RSpec.describe "customers/new", type: :view do
  before(:each) do
    assign(:customer, Customer.new(
      :firstname => "MyString",
      :lastname => "MyString",
      :email => "MyString",
      :password => "MyString"
    ))
  end

  it "renders new customer form" do
    render

    assert_select "form[action=?][method=?]", customers_path, "post" do

      assert_select "input#customer_firstname[name=?]", "customer[firstname]"

      assert_select "input#customer_lastname[name=?]", "customer[lastname]"

      assert_select "input#customer_email[name=?]", "customer[email]"

      assert_select "input#customer_password[name=?]", "customer[password]"
    end
  end
end
