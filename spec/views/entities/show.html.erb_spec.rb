require 'rails_helper'

RSpec.describe "entities/show", type: :view do
  before(:each) do
    assign(:entity, Entity.create!(
      author: "Author",
      name: "Name",
      amount: 2,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
