require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  it { is_expected.to have_valid(:username).when('boringusername') }
  it { is_expected.to_not have_valid(:username).when(nil, '') }
  it { expect(user).to validate_uniqueness_of(:username) }

  it { is_expected.to have_valid(:email).when('boring@gmail.com') }
  it { is_expected.to_not have_valid(:email).when(nil, '') }
  it { expect(user).to validate_uniqueness_of(:email) }

  it { is_expected.to have_valid(:encrypted_password).when('123456') }
  it { is_expected.to_not have_valid(:encrypted_password).when(nil, '') }
end
