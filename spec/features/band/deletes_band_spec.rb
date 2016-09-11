require 'rails_helper'

feature 'user deletes band' do
  let!(:user) { FactoryGirl.create(:user, bands: [band, another_band]) }
  let!(:band) { FactoryGirl.create(:band) }
  let!(:another_band) { FactoryGirl.create(:band) }

  before do
    sign_in(user)
  end

  scenario 'user deletes from band show page' do
    visit band_path(band)
    page.find(".delete-band-#{band.id}").click

    expect(current_path).to eq(bands_path)

    expect(page).to have_content(/#{another_band[:name]}/i)

    expect(page).not_to have_content(/#{band[:name]}/i)
  end
end
