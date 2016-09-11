require 'rails_helper'

feature 'user edits setlist' do
  let!(:user) { FactoryGirl.create(:user, bands: [band]) }
  let!(:band) { FactoryGirl.create(:band) }
  let!(:setlist) { FactoryGirl.create(:setlist, band: band) }
  let!(:new_setlist) { FactoryGirl.build(:setlist) }

  before do
    sign_in(user)
  end

  scenario 'visits edit setlist form' do
    visit setlist_path(setlist)
    page.find(".edit-setlist-#{setlist.id}").click

    expect(current_path).to eq(edit_setlist_path(setlist))

    expect(page).to have_selector('form')

    expect(page).to have_content('Venue or Show Name')
    expect(page).to have_content('Show Date')
    expect(page).to have_content('Band')

    expect(find('#setlist_venue').value).to eq(setlist[:venue])
  end

  scenario 'inputs valid fields' do
    visit edit_setlist_path(setlist)

    fill_in 'setlist[venue]', with: new_setlist[:venue]
    select new_setlist.date.day, from: 'setlist[date(3i)]'
    select new_setlist.date.strftime("%B"), from: 'setlist[date(2i)]'
    select new_setlist.date.year, from: 'setlist[date(1i)]'

    click_button 'Save'

    expect(page).to have_content('Setlist successfully saved!')
    expect(page).to have_content(/#{new_setlist[:venue]}/i)
  end

  scenario 'does not complete required fields' do
    visit edit_setlist_path(setlist)
    fill_in 'setlist[venue]', with: ''
    click_button 'Save'

    expect(page).not_to have_content('Setlist successfully saved!')
    expect(page).to have_content("Venue or name can't be blank")
    expect(page).to have_content('There were problems saving your setlist')
  end
end
