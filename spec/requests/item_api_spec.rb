require 'rails_helper'

RSpec.describe "APIs" do
  it "returns all items" do
    create_list(:item, 3)
    get '/api/v1/items'
    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"
    expect(response).to be_success
  end
  it "can create a new item" do
    item_params = {name: "Saw",
                   description: "I want to play a game"}
    post "/api/v1/items", params: {item: item_params}
    expect(response).to be_success
    item = Item.last

    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = {name: "Saw",
                   description: "I want to play a game"}
    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)
    expect(response).to be_success
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
  end
  it "can delete an item" do
    item = create(:item)

    expect(Item.count).to eq(1)
    delete "/api/v1/items/#{item.id}"
    expect(response).to be_success
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
