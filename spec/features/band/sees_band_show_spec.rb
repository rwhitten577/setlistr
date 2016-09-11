require 'rails_helper'

feature 'user sees band details' do
  let!(:band) { FactoryGirl.create(:band) }
  let!(:another_band) { FactoryGirl.create(:band) }
  let!(:user1) { FactoryGirl.create(:user, bands: [band]) }
  let!(:user2) { FactoryGirl.create(:user, bands: [band]) }
  let!(:user3) { FactoryGirl.create(:user, bands: [band]) }
  let!(:user4) { FactoryGirl.create(:user, bands: [another_band]) }
  let!(:setlist1) { FactoryGirl.create(:setlist, band: band)}
  let!(:setlist2) { FactoryGirl.create(:setlist, band: band)}

  context 'authenticated user' do
    before do
      sign_in(user1)
      visit band_path(band)
    end

    scenario 'sees list of the band members' do
      expect(page).to have_content(/#{user1[:username]}/i)
      expect(page).to have_content(/#{user2[:username]}/i)
      expect(page).to have_content(/#{user3[:username]}/i)
      expect(page).to have_content(/#{band[:name]}/i)

      expect(page).not_to have_content(/#{user4[:username]}/i)
      expect(page).not_to have_content(/#{another_band[:name]}/i)

      expect(page).to have_link('Invite Members')
    end

    scenario 'sees all setlists for the band' do
      expect(page).to have_content(setlist1[:venue])
      expect(page).to have_content(setlist1[:date])
      expect(page).to have_content(setlist2[:venue])
      expect(page).to have_content(setlist2[:date])
    end
  end
end
