require 'rails_helper'

feature 'user sees setlist details' do
  let!(:band) { FactoryGirl.create(:band) }
  let!(:user) { FactoryGirl.create(:user, bands: [band]) }
  let!(:setlist) { FactoryGirl.create(:setlist, band: band)}

  context 'authenticated user' do
    before do
      sign_in(user)
      visit setlist_path(setlist)
    end

    scenario 'sees list of the band members' do
      expect(page).to have_content(/#{band[:name]}/i)
      expect(page).to have_content(/#{setlist[:venue]}/i)
      expect(page).to have_content(/#{setlist[:date]}/i)

      expect(page).to have_link('Print')
    end

    # scenario 'sees all songs for the setlist' do
    #   expect(page).to have_content(song1[:name])
    #   expect(page).to have_content(song2[:name])
    # end
  end
end
