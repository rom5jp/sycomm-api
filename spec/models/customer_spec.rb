require 'rails_helper'

RSpec.describe User, type: :model do
  let(:customer) { build(:customer) }

  it { is_expected.to have_many(:tasks).dependent(:destroy) }
  # cpf
  it { is_expected.to validate_presence_of(:cpf) }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to validate_numericatliy_of(:registration) }

  it { is_expected.to validate_confirmation_of(:password) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value('romero@gmail.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#generate_authentication_token!' do
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xyzTOKEN')
    end

    it 'generates another auth token when the current auth token already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz', 'abcXYZ123456789')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end