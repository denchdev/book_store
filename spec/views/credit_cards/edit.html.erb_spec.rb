require 'rails_helper'

RSpec.describe "credit_cards/edit", type: :view do
  before(:each) do
    @credit_card = assign(:credit_card, CreditCard.create!(
      :number => 1,
      :CVV => 1,
      :expiration_month => 1,
      :expiration_year => 1,
      :firstname => "MyString",
      :lastname => "MyString"
    ))
  end

  it "renders the edit credit_card form" do
    render

    assert_select "form[action=?][method=?]", credit_card_path(@credit_card), "post" do

      assert_select "input#credit_card_number[name=?]", "credit_card[number]"

      assert_select "input#credit_card_CVV[name=?]", "credit_card[CVV]"

      assert_select "input#credit_card_expiration_month[name=?]", "credit_card[expiration_month]"

      assert_select "input#credit_card_expiration_year[name=?]", "credit_card[expiration_year]"

      assert_select "input#credit_card_firstname[name=?]", "credit_card[firstname]"

      assert_select "input#credit_card_lastname[name=?]", "credit_card[lastname]"
    end
  end
end
