require 'rails_helper'

feature 'user sees their setlists' do
  let!(:band) { FactoryGirl.create(:band) }
  let!(:another_band) { FactoryGirl.create(:band) }
  let!(:yet_another_band) { FactoryGirl.create(:band)}
  let!(:user) { FactoryGirl.create(:user, bands: [band, another_band]) }
  let!(:setlist1) { FactoryGirl.create(:setlist, band: band) }
  let!(:setlist2) { FactoryGirl.create(:setlist, band: another_band) }
  let!(:setlist3) { FactoryGirl.create(:setlist, band: yet_another_band) }
  let!(:setlist4) { FactoryGirl.create(:setlist, band: band) }

  context 'authenticated user from setlist index' do
    before do
      sign_in(user)
      visit setlists_path
    end

    scenario 'sees list of their setlists across different bands' do
      expect(page).to have_content(/Your Setlists/i)
      expect(page).to have_content(/#{band[:name]}/i)
      expect(page).to have_content(/#{another_band[:name]}/i)
      expect(page).to have_content(/#{setlist1[:venue]}/i)
      expect(page).to have_content(/#{setlist2[:venue]}/i)
      expect(page).to have_link(setlist1[:venue])
      expect(page).to have_link(setlist1[:date])

      expect(page).not_to have_content(yet_another_band[:name])
      expect(page).not_to have_content(setlist3[:venue])

      expect(page).to have_link('Create New Setlist')
    end
  end

  context 'authenticated user from band show' do
    before do
      sign_in(user)
      visit band_path(band)
    end

    scenario 'sees list of setlists for band' do
      expect(page).to have_content(/#{band[:name]}/i)
      expect(page).to have_content(/#{setlist1[:venue]}/i)
      expect(page).to have_content(/#{setlist4[:venue]}/i)
      expect(page).to have_content(/#{setlist1[:date]}/i)
      expect(page).to have_content(/#{setlist4[:date]}/i)
      expect(page).to have_link(setlist4[:venue])
      expect(page).to have_link(setlist4[:date])

      expect(page).not_to have_content(setlist2[:venue])

      expect(page).to have_link('Create New Setlist')
    end
  end
end
