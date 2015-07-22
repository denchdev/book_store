require 'rails_helper'

RSpec.describe "credit_cards/index", type: :view do
  before(:each) do
    assign(:credit_cards, [
      CreditCard.create!(
        :number => 1,
        :CVV => 2,
        :expiration_month => 3,
        :expiration_year => 4,
        :firstname => "Firstname",
        :lastname => "Lastname"
      ),
      CreditCard.create!(
        :number => 1,
        :CVV => 2,
        :expiration_month => 3,
        :expiration_year => 4,
        :firstname => "Firstname",
        :lastname => "Lastname"
      )
    ])
  end

  it "renders a list of credit_cards" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Firstname".to_s, :count => 2
    assert_select "tr>td", :text => "Lastname".to_s, :count => 2
  end
end
