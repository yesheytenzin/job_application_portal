# # frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Admin::V1::JobApplications', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:admin) { create :user, :admin }
  let(:applicant) { create :user, :applicant }
  let(:job) { create :job }
  let(:job_application) { create(:job_application, user: applicant, job: job) }

  before { sign_in admin }

  describe 'GET /api/admin/v1/job_application' do
    it 'expects to show all user job applications' do
      get api_admin_v1_job_applications_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/admin/v1/job_application/:id' do
    it 'expect to show a user job application' do
      get api_admin_v1_job_application_path(job_application.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /api/admin/v1/job_application/:id' do
    let(:valid_params) { { status: :accepted } }

    it 'expect to update the status of job application' do
      put api_admin_v1_job_application_path(job_application.id), params: { job_application: valid_params }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/admin/v1/job_application/:id' do
    it 'expects to delete the user' do
      delete api_admin_v1_job_application_path(job_application.id)
      expect(response).to have_http_status(:ok)
    end
  end
end
