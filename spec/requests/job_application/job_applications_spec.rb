# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::User::V1::JobApplications', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:applicant) { create :user, :applicant }
  let(:job) { create :job }
  let(:job_application) { create(:job_application, user: applicant, job: job) }

  before { sign_in applicant }

  describe 'GET /api/user/v1/job_application' do
    it 'return applicatsall job applications' do
      get api_user_v1_job_applications_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/user/v1/job_application/:id' do
    it 'returns particular job application for the applicant user' do
      get api_user_v1_job_application_path(job_application.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/user/v1/job_application' do
    let(:new_user) { create :user, :applicant }
    let(:valid_params) do
      {
        job_id: job.id,
        resume: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/app.pdf'), 'application/pdf'),
        cover_letter: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/app.pdf'), 'application/pdf')
      }
    end

    it 'create a new job application' do
      sign_in new_user
      post api_user_v1_job_applications_path, params: { job_application: valid_params }
      expect(response).to have_http_status(:created)
    end
  end
end
