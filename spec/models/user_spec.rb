require "rails_helper"

RSpec.describe User, type: :model do
  describe "devise modules test" do
    it "is database authenticatable" do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it "is registerable" do
      expect(User.devise_modules).to include(:registerable)
    end

    it "is validatable" do
      expect(User.devise_modules).to include(:validatable)
    end
  end

  describe "validations" do
    subject { FactoryBot.build(:user) }

    it { is_expected.to be_valid }

    it "requires email" do
      subject.email = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:email]).to include("can't be blank")
    end

    it "needs to have a unique email" do
      existing_user = FactoryBot.create(:user)
      subject.email = existing_user.email
      expect(subject).not_to be_valid
      expect(subject.errors[:email]).to include("has already been taken")
    end

    it "needs to have a valid email format" do
      invalid_user = FactoryBot.build(:user, :with_invalid_email)
      expect(invalid_user).not_to be_valid
      expect(invalid_user.errors[:email]).to include("is invalid")
    end

    it "requires a password" do
      subject.password = nil
      expect(subject).not_to be_valid
    end

    it "requires a minimum password length of 8" do
      short_user = FactoryBot.build(:user, :with_short_password)
      expect(short_user).not_to be_valid
      expect(short_user.errors[:password]).to include("is too short (minimum is 8 characters)")
    end
  end

  describe "password encryption" do
    it "encrypts the password" do
      user = FactoryBot.create(:user)
      expect(user.encrypted_password).to be_present
      expect(user.encrypted_password).not_to eq(user.password)
    end
  end

  describe "#valid password?" do
    it "returns true for valid passwords" do
      raw_password = Faker::Internet.password(min_length: 8)
      user = FactoryBot.create(:user, password: raw_password, password_confirmation: raw_password)
      expect(user.valid_password?(raw_password)).to be true
    end

    it "return false for invalid passwords" do
      user = FactoryBot.create(:user)
      expect(user.valid_password?(Faker::Internet.password(min_length: 8))).to be false
    end
  end
end
