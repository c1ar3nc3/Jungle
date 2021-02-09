require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new
      @category.name = "Essentials"
      @category.save!
      @product = Product.new
      @product.name = "Crude Oil"
    end

  it "should save if all fields are filled" do
    @product.price = 123
    @product.quantity = 1
    @product.category_id = @category.id
    @product.save!
  end

  it "should show a name error if name is blank" do
    @product.name = nil
    @product.price = 123
    @product.quantity = 1
    @product.category_id = @category.id
    @product.save
    expect(@product.errors.full_messages).to include("Name can't be blank")
  end

  it "should show a price error if price is blank" do
    @product.price = nil
    @product.quantity = 2
    @product.category_id = @category.id
    @product.save
    expect(@product.errors.full_messages).to include("Price can't be blank")
  end

  it "should show a quantity error if quantity is blank" do
    @product.price = 123
    @product.quantity = nil
    @product.category_id = @category.id
    @product.save
    expect(@product.errors.full_messages).to include("Quantity can't be blank")
  end

  it "should show a category error if category is blank" do
    @product.price = 123
    @product.quantity = 2
    @product.category_id = nil
    @product.save
    expect(@product.errors.full_messages).to include("Category can't be blank")
  end

end
end
