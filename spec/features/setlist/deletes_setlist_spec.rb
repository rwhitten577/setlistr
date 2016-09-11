require 'rails_helper'

feature 'user deletes setlist' do
  let!(:user) { FactoryGirl.create(:user, bands: [band]) }
  let!(:band) { FactoryGirl.create(:band) }
  let!(:setlist) { FactoryGirl.create(:setlist, band: band) }
  let!(:another_setlist) { FactoryGirl.create(:setlist, band: band) }

  before do
    sign_in(user)
  end

  scenario 'user deletes from band show page' do
    visit setlist_path(setlist)
    page.find(".delete-setlist-#{setlist.id}").click

    expect(current_path).to eq(setlists_path)

    expect(page).to have_content(/#{another_setlist[:venue]}/i)

    expect(page).not_to have_content(/#{setlist[:venue]}/i)
  end
end
