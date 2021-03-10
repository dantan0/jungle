require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    User.create!(
      first_name: 'Yolanda',
      last_name: 'Steamer',
      email: 'yoyo@gmail.com',
      password: 'yoyopower',
      password_confirmation: 'yoyopower'
    )
  end

  scenario 'a valid user can log in from home' do
    visit root_path
    find_link('Log In').click()
    expect(page).to have_css('section.session-new')

    within 'form' do
      fill_in id: 'email', with: 'yoyo@gmail.com'
      fill_in id: 'password', with: 'yoyopower'
      click_on 'Submit'
    end

    puts page.html
    expect(page).to have_content('Logout')
    save_screenshot
  end
end
