require 'rails_helper'

RSpec.describe "credit_cards/show", type: :view do
  before(:each) do
    @credit_card = assign(:credit_card, CreditCard.create!(
      :number => 1,
      :CVV => 2,
      :expiration_month => 3,
      :expiration_year => 4,
      :firstname => "Firstname",
      :lastname => "Lastname"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Firstname/)
    expect(rendered).to match(/Lastname/)
  end
end
