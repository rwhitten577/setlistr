require 'rails_helper'

feature 'user sees their setlists' do
  let!(:band) { FactoryGirl.create(:band) }
  let!(:another_band) { FactoryGirl.create(:band) }
  let!(:yet_another_band) { FactoryGirl.create(:band)}
  let!(:user) { FactoryGirl.create(:user, bands: [band, another_band]) }
  let!(:another_user) { FactoryGirl.create(:user, bands: [yet_another_band]) }

  context 'authenticated user' do
    before do
      sign_in(user)
      visit setlists_path
    end

    scenario 'sees list of their bands' do
      expect(page).to have_content(/Your Bands/i)
      expect(page).to have_content(/#{band[:name]}/i)
      expect(page).to have_content(/#{another_band[:name]}/i)
      expect(page).to have_link(band[:name])
      expect(page).to have_link(another_band[:name])

      expect(page).not_to have_content(yet_another_band[:name])

      expect(page).to have_link('Add New Band')
    end
  end
end
