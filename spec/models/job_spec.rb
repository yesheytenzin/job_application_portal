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

  describe 'attachments' do
    it 'accepts pdf files' do
      job.attachments.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/app.pdf')),
        filename: 'app.pdf',
        content_type: 'application/pdf'
      )
      expect(job).to be_valid
    end

    it 'rejects invalid file type' do
      job.attachments.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/app.exe')),
        filename: 'app.exe',
        content_type: 'application/octet-stream'
      )
      expect(job).not_to be_valid
      expect(job.errors[:attachments]).to be_present
    end

    it 'rejects file size greater than 10mb' do
      file = Tempfile.new('large.pdf')
      file.write('a' * 11.megabytes)
      file.rewind

      job.attachments.attach(
        io: file,
        filename: 'large.pdf',
        content_type: 'application/pdf'
      )

      expect(job).not_to be_valid
      expect(job.errors[:attachments]).to be_present

      file.close
      file.unlink
    end
  end
end
