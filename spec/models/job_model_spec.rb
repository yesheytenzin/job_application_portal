# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  subject(:job) { build(:job) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:min_salary) }
    it { is_expected.to validate_presence_of(:max_salary) }
  end
end
