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
    expect(page).to have_css('article.product', count: 3)
    
    find_link('Details', match: :first).click

    puts page.html

    # DEBUG
    # sleep 1
    # save_screenshot
    
    
    # VERIFY
    expect(page).to have_css('article.product-detail', count: 1)
    expect(page).to have_css('img.main-img')

  end
end