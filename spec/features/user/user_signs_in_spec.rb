require 'rails_helper'

feature 'user creates account' do
  let(:user) { FactoryGirl.create(:user) }
  let(:another_user) { FactoryGirl.attributes_for(:user) }

  scenario 'user sees sign in form' do
    visit root_path
    click_link('Sign In', match: :first)

    expect(current_path).to eq(new_user_session_path)

    expect(page).to have_selector('form')

    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_button('Sign in')
  end

  scenario 'user inputs correct fields' do
    visit root_path
    click_link('Sign In', match: :first)
    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully')

    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  scenario 'user inputs incorrect fields' do
    visit root_path
    click_link('Sign In', match: :first)
    fill_in 'Email', with: another_user[:email]
    fill_in 'Password', with: another_user[:password]
    click_button 'Sign in'

    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'user leaves out required fields' do
    visit root_path
    click_link('Sign In', match: :first)
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Sign in'

    expect(page).to have_content('Invalid Email or password')
  end
end
