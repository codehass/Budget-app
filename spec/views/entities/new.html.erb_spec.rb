require 'rails_helper'

RSpec.describe "entities/new", type: :view do
  before(:each) do
    assign(:entity, Entity.new(
      author: "MyString",
      name: "MyString",
      amount: 1,
      user: nil
    ))
  end

  it "renders new entity form" do
    render

    assert_select "form[action=?][method=?]", entities_path, "post" do

      assert_select "input[name=?]", "entity[author]"

      assert_select "input[name=?]", "entity[name]"

      assert_select "input[name=?]", "entity[amount]"

      assert_select "input[name=?]", "entity[user_id]"
    end
  end
end
