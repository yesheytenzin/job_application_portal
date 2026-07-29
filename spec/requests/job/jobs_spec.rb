# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Jobs', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { create :user, :admin }

  before do
    create :job, user: user
  end

  describe 'GET /api/v1/jobs' do
    context 'with authentication' do
      before { sign_in user }

      it 'all the jobs' do
        get api_v1_jobs_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without authentication' do
      it 'all the jobs' do
        get api_v1_jobs_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /api/v1/jobs/:id' do
    context 'with authentication' do
      before { sign_in user }

      let(:job) { create :job, user: user }

      it 'shows the job' do
        get api_v1_job_path(job.id)
        expect(response).to have_http_status(:ok)
      end

      it 'does not show job having no id' do
        get api_v1_job_path(1212)
      expect(response).to have_http_status(:not_found)
      end
    end

    context 'without authentication' do
      let(:job) { create :job, user: user }

      it 'shows the job' do
        get api_v1_job_path(job.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /api/v1/jobs' do
    context 'with authentication' do
      before { sign_in user }

      let(:valid_params) { attributes_for(:job) }

      it 'create job' do
        expect do
          post api_v1_jobs_path, params: { job: valid_params }
        end.to change(Job, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'without authentication' do
      let(:valid_params) { attributes_for(:job) }

      it 'fails to create job' do
        post api_v1_jobs_path, params: { job: valid_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/jobs/:id' do
    context 'with authentication admin user' do
      let(:job) { create :job, user: user }
      let(:valid_params) { { job: { status: :open } } }

      before { sign_in user }

      it 'update job' do
        put api_v1_job_path(job.id), params: valid_params
        expect(response).to have_http_status(:ok)
        expect(job.reload.status).to eq 'open'
      end
    end

    context 'without authentication' do
      let(:job) { create :job, user: user }
      let(:valid_params) { { job: { status: :open } } }

      it 'fails to update job' do
        put api_v1_job_path(job.id), params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with applicant user' do
      let(:user) { create :user, :applicant }
      let(:job) { create :job, user: user }
      let(:valid_params) { attributes_for(:job) }

      before { sign_in user }

      it 'fails to create job' do
        post api_v1_jobs_path, params: valid_params
        expect(response).to have_http_status(:forbidden)
      end

      context 'when update job' do
        let!(:valid_params) { { job: { status: :open } } }

        it 'fails for non admin user' do
         put api_v1_job_path(job.id), params: valid_params
         expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'DELETE /api/v1/jobs/:id' do
    context 'with admin authentication' do
      let(:user) { create :user, :admin }
      let(:job) { create :job, user: user }

      before { sign_in user }

      it 'deletes job' do
        delete api_v1_job_path(job.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'without admin authentication but applicant user' do
      let(:user) { create :user, :applicant }
      let(:job) { create :job }

      before { sign_in user }

      it 'fails to delete job' do
        delete api_v1_job_path(job.id)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when no user authenticated' do
      let(:job) { create :job }

      it 'fails to delete job' do
        delete api_v1_job_path(job.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
