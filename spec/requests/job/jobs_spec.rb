# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Job::V1::Jobs', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { create :user, :admin }
  let(:job) { create :job, user: user }

  describe 'GET /api/job/v1/jobs' do
    context 'with authentication' do
      before { sign_in user }

      it 'get all the jobs' do
        get api_job_v1_jobs_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without authentication' do
      it 'get all the jobs' do
        get api_job_v1_jobs_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/job/v1/jobs/:id' do
    context 'with authentication' do
      before { sign_in user }

      it 'shows the job' do
        get api_job_v1_job_path(job.id)
        expect(response).to have_http_status(:ok)
      end

      it 'does not show job having no id' do
        get api_job_v1_job_path(1212)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'without authentication' do
      it 'shows the job' do
        get api_job_v1_job_path(job.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
