require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create! first_name: 'First', last_name: "Last", email: 'test@gmail.com', password: 'abc123', password_confirmation: 'abc123' 
  end 


  scenario "They see all products" do
    visit root_path
    find_link('Login').click

    fill_in 'email', with: 'test@gmail.com'
    fill_in 'password', with: 'abc123'

    page.find('input.btn').click

    # sleep 1
    # save_screenshot

    expect(page).to have_link('Logout')
  end
end
