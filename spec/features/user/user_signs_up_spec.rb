require 'rails_helper'

feature 'user creates account' do
  let(:user) { FactoryGirl.attributes_for(:user) }

  scenario 'user sees sign up form' do
    visit root_path
    click_link('Sign Up', match: :first)

    expect(current_path).to eq(new_user_registration_path)

    expect(page).to have_selector('form')

    expect(page).to have_content('Username')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_button('Sign up')
  end

  scenario 'user inputs all required fields' do
    visit root_path
    click_link('Sign Up', match: :first)
    fill_in 'Username', with: user[:username]
    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    click_button 'Sign up'
  end

  scenario 'user leaves out required fields' do
    visit root_path
    click_link('Sign Up', match: :first)
    fill_in 'Username', with: ''
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_button 'Sign up'

    expect(page).to have_content("Username can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Encrypted password can't be blank")
  end
end
