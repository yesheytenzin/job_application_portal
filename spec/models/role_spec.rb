# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { build(:role) }

  describe 'association' do
    it { is_expected.to have_many(:users).dependent(:restrict_with_error) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'constant' do
    it 'defines role name constant' do
      expect(Role::ADMIN).to eq 'admin'
      expect(Role::APPLICANT).to eq 'applicant'
    end
  end

  describe 'scope' do
    before do
      create(:role, :admin)
      create(:role, :applicant)
    end

    it 'returns admin' do
      expect(described_class.admin.name).to eq 'admin'
    end

    it 'returns applicant' do
      expect(described_class.applicant.name).to eq 'applicant'
    end
  end

  describe 'dependent: restrict_with_error' do
    it 'prevent user deletion when assigned' do
      role = create(:role, :admin)
      create(:user, role: role)

      expect { role.destroy }.not_to change(described_class, :count)
      expect(role.errors[:base]).to be_present
    end
  end
end
