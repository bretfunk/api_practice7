require 'rails_helper'

RSpec.describe "APIs" do
  it "returns all items" do
    create_list(:item, 3)
    get '/api/v1/items'
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
end
