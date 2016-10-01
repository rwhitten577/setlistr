require 'rails_helper'

RSpec.describe Song, type: :model do
  it { is_expected.to have_valid(:name).when('Changes in Latitudes') }
  it { is_expected.to_not have_valid(:name).when(nil, '') }
end
