require 'rails_helper'

RSpec.feature "Visitor navigates to cart page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'They can purchase a product' do
    visit root_path
    first('article.product').find_button('Add').click()
    expect(page).to have_content('My Cart (1)')
    find_link('My Cart (1)').click()
    expect(find('header.page-header')).to have_content('My Cart')
    expect(page).to have_content('1')
    expect(page).to have_content('64.99')
    save_screenshot
  end
end
