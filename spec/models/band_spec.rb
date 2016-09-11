require 'rails_helper'

RSpec.describe Band, type: :model do
  it { is_expected.to have_valid(:name).when('Spinal Tap') }
  it { is_expected.to_not have_valid(:name).when(nil, '') }
end
