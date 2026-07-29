require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to belong_to(:role) }
    it { is_expected.to have_one(:profile).dependent(:destroy) }
    it { is_expected.to have_many(:jobs).dependent(:destroy) }
  end

  describe 'admin?' do
    it 'return true for admin user' do
      user = build(:user, :admin)
      expect(user.admin?).to be true
    end

    it 'return false for non-admin user' do
      user = build(:user, :applicant)
      expect(user.admin?).to be false
    end
  end

  describe 'applicant?' do
    it 'return true for applicant user' do
      user = build(:user, :applicant)
      expect(user.applicant?).to be true
    end
  end


  describe 'devise modules' do
    it 'includes Devise modules' do
      expect(described_class.devise_modules).to contain_exactly(:database_authenticatable, :registerable, :validatable)
    end

    describe 'validations' do
      subject(:user) { create(:user) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.to allow_value('user@example.com').for(:email) }
      it { is_expected.not_to allow_value('invalid_email').for(:email) }
      it { is_expected.to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(8) }
    end

    describe 'password encryption' do
      it 'encrypts the password' do
        user = create(:user)
        expect(user.encrypted_password).to be_present
        expect(user.encrypted_password).not_to eq(user.password)
      end
    end

    describe '#valid password?' do
      let(:password) { 'password' }
      let(:user) { create(:user, password: password, password_confirmation: password) }

      it 'returns true for valid passwords' do
        expect(user.valid_password?(password)).to be(true)
      end

      it 'return false for invalid passwords' do
        expect(user.valid_password?('Wrong password')).to be(false)
      end
    end
  end
end
