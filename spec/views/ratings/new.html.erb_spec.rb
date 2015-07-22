require 'rails_helper'

RSpec.describe "ratings/new", type: :view do
  before(:each) do
    assign(:rating, Rating.new(
      :rewiev => "MyText",
      :rating => 1
    ))
  end

  it "renders new rating form" do
    render

    assert_select "form[action=?][method=?]", ratings_path, "post" do

      assert_select "textarea#rating_rewiev[name=?]", "rating[rewiev]"

      assert_select "input#rating_rating[name=?]", "rating[rating]"
    end
  end
end
