require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    3.times do |n|
      @category.products.create!(
        name: "Click Me",
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

  end

  scenario "They see all products" do
    # ACT
    visit root_path
    
    click_button('Add', match: :first)

    # DEBUG
    # sleep 1
    # save_screenshot
    
    # VERIFY
    expect(page).to have_content('My Cart (1)')

  end
end