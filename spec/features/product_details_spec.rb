require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
      )
      @one_product = Product.first
    end
  end

  scenario "Select a product from the home page" do
    visit root_path
    click_on @one_product.name
    expect(page).to have_css('article.product-detail')
    # commented out b/c it's for debugging only
    # save_and_open_screenshot
  end


end
