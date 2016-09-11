require 'rails_helper'

RSpec.describe Setlist, type: :model do
  it { is_expected.to have_valid(:venue).when('Pickled Onion') }
  it { is_expected.to_not have_valid(:venue).when(nil, '') }
  it { is_expected.to have_valid(:date).when(Date.today) }
  it { is_expected.to_not have_valid(:date).when(nil, '') }
end
