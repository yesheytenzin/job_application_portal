# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  subject(:job_application) { build(:job_application) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:job) }
  end

  describe 'validations' do
    subject(:job_application) { create(:job_application) }

    it { is_expected.to validate_presence_of(:status) }

    it do
      expect(job_application).to validate_uniqueness_of(:user_id)
        .scoped_to(:job_id)
    end
  end
end
