# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { build(:role) }

  describe 'association' do
    it { is_expected.to have_many(:users).dependent(:restrict_with_error) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }

    it 'requires name to be unique' do
      create(:role, :applicant)
      duplicate_role = build(:role, :applicant)
      expect(duplicate_role).not_to be_valid
      expect(duplicate_role.errors[:name]).to include('has already been taken')
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
