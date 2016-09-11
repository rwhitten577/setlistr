require 'rails_helper'

feature 'user edits setlist' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:band) { FactoryGirl.create(:band) }
  let!(:another_band) { FactoryGirl.build(:band) }

  before do
    sign_in(user)
  end

  scenario 'visits edit band form' do
    visit band_path(band)
    page.find(".edit-band-#{band.id}").click

    expect(current_path).to eq(edit_band_path(band))

    expect(page).to have_selector('form')

    expect(page).to have_content('Band Name')
    expect(page).to have_content('Members')

    expect(find('#band_name').value).to eq(band[:name])
  end

  context 'user edits from band show' do
    scenario 'inputs valid name' do
      visit edit_band_path(band)

      fill_in 'band_name', with: another_band[:name]
      click_button 'Save'

      expect(page).to have_content('Band successfully saved!')
      expect(page).to have_content(/#{another_band[:name]}/i)
    end

    scenario 'does not complete any required fields' do
      visit edit_band_path(band)
      fill_in 'band_name', with: ''
      click_button 'Save'

      expect(page).not_to have_content('Band successfully saved!')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('There were problems saving your band')
    end
  end
end
