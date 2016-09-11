require 'rails_helper'

feature 'user creates setlist' do
  context 'band does not exist' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:setlist) { FactoryGirl.build(:setlist) }

    scenario 'does not complete required fields' do
      sign_in(user)
      visit new_setlist_path

      fill_in 'setlist_venue', with: ''

      click_button 'Create Setlist'

      expect(page).not_to have_content('Setlist successfully created!')
      expect(page).to have_content("Venue or name can't be blank")
      expect(page).to have_content("You must select a band or create a new one")
      expect(page).to have_content('There were problems saving your setlist')
    end
  end

  context 'band already exists, creates from setlist index' do
    let!(:band) { FactoryGirl.create(:band) }
    let!(:band2) { FactoryGirl.create(:band) }
    let!(:user) { FactoryGirl.create(:user, bands: [band, band2]) }
    let!(:setlist) { FactoryGirl.build(:setlist) }
    # let!(:song) { FactoryGirl.create(:song, band: band) }
    before do
      sign_in(user)
    end

    scenario 'visits new setlist form' do
      visit setlists_path
      click_link 'Create New Setlist'

      expect(current_path).to eq(new_setlist_path)

      expect(page).to have_selector('form')

      expect(page).to have_content('Venue or Show Name')
      expect(page).to have_content('Show Date')
      expect(page).to have_content('Band')
    end

    scenario 'inputs valid venue and date' do
      visit new_setlist_path

      fill_in 'setlist_venue', with: setlist[:venue]

      select setlist.date.day, from: 'setlist[date(3i)]'
      select setlist.date.strftime("%B"), from: 'setlist[date(2i)]'
      select setlist.date.year, from: 'setlist[date(1i)]'
      select band2.name, from: 'setlist[band]'

      click_button 'Create Setlist'

      expect(page).to have_content('Setlist successfully created!')
      expect(page).to have_content(/#{band2[:name]}/i)
      expect(page).to have_content(/#{setlist[:venue]}/i)
      expect(page).to have_content(/#{setlist[:date]}/i)
    end

    scenario 'does not complete required fields' do
      visit new_setlist_path

      fill_in 'setlist_venue', with: ''

      click_button 'Create Setlist'

      expect(page).not_to have_content('Setlist successfully created!')
      expect(page).to have_content("Venue or name can't be blank")
      expect(page).to have_content('There were problems saving your setlist')
    end
  end

  context 'creates from band show' do
    let!(:band) { FactoryGirl.create(:band) }
    let!(:band2) { FactoryGirl.create(:band) }
    let!(:user) { FactoryGirl.create(:user, bands: [band, band2]) }
    let!(:setlist) { FactoryGirl.build(:setlist) }
    
    before do
      sign_in(user)
    end

    scenario 'visits new setlist form' do
      visit band_path(band)
      click_link 'Create New Setlist'

      expect(current_path).to eq(new_band_setlist_path(band))

      expect(page).to have_selector('form')

      expect(page).to have_content('Venue or Show Name')
      expect(page).to have_content('Show Date')
      expect(page).to have_content('Band')
    end

    scenario 'inputs valid venue and date' do
      visit new_band_setlist_path(band)

      fill_in 'setlist_venue', with: setlist[:venue]

      select setlist.date.day, from: 'setlist[date(3i)]'
      select setlist.date.strftime("%B"), from: 'setlist[date(2i)]'
      select setlist.date.year, from: 'setlist[date(1i)]'

      click_button 'Create Setlist'

      expect(page).to have_content('Setlist successfully created!')
      expect(page).to have_content(/#{band[:name]}/i)
      expect(page).to have_content(/#{setlist[:venue]}/i)
      expect(page).to have_content(/#{setlist[:date]}/i)
    end
  end
end
