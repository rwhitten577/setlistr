require 'rails_helper'

feature 'user creates band' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:band) { FactoryGirl.build(:band) }

  context 'authenticated user' do
    before do
      sign_in(user)
    end

    scenario 'visits new band form' do
      visit bands_path
      click_link 'Add New Band'

      expect(current_path).to eq(new_band_path)

      expect(page).to have_selector('form')

      expect(page).to have_content('Band Name')
      expect(page).to have_content('Invite Members')
    end

    scenario 'inputs valid name' do
      visit new_band_path

      fill_in 'band_name', with: band[:name]
      click_button 'Create Band'

      expect(page).to have_content('Band successfully created!')
      expect(page).to have_content(/#{band[:name]}/i)
      expect(page).to have_content(/#{user[:username]}/i)
    end

    scenario 'does not complete any required fields' do
      visit bands_path
      click_link 'Add New Band'

      fill_in 'band_name', with: ''
      click_button 'Create Band'

      expect(page).not_to have_content('Band successfully created!')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('There were problems saving your band')
    end
  end
end
