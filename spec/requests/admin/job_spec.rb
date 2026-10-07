# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Jobs', type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { create :user, :admin }
  let!(:job) { create(:job, user: user) }

  describe 'POST /api/admin/v1/jobs' do
    let(:valid_params) { attributes_for(:job) }

    context 'with admin authentication' do
      before { sign_in user }

      it 'create job' do
        expect do
          post api_admin_v1_jobs_path, params: { job: valid_params }
        end.to change(Job, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'without admin authentication' do
      it 'fails to create job' do
        post api_admin_v1_jobs_path, params: { job: valid_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/admin/v1/jobs/:id' do
    let(:valid_params) { { status: :open } }

    context 'with admin authentication' do
      before { sign_in user }

      it 'update job' do
        put api_admin_v1_job_path(job.id), params: { job: valid_params }
        expect(response).to have_http_status(:ok)
        expect(job.reload.status).to eq 'open'
      end
    end

    context 'without admin authentication' do
      let(:user) { create :user, :applicant }
      let(:job) { create :job, user: user }

      it 'fails to update job' do
        put api_admin_v1_job_path(job.id), params: { job: valid_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with applicant user' do
      let(:user) { create :user, :applicant }
      let(:job) { create :job, user: user }
      let(:valid_params) { attributes_for(:job) }

      before { sign_in user }

      it 'fails to create job' do
        post api_admin_v1_jobs_path, params: { job: valid_params }
        expect(response).to have_http_status(:forbidden)
      end

      context 'when update job' do
        let(:valid_params) { { status: :open } }

        it 'fails for non admin user' do
         put api_admin_v1_job_path(job.id), params: { job: valid_params }
         expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'DELETE /api/admin/v1/jobs/:id' do
    context 'with admin authentication' do
      before { sign_in user }

      it 'deletes job' do
        expect do
          delete api_admin_v1_job_path(job.id)
        end.to change(Job, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with applicant user' do
      let(:user) { create :user, :applicant }
      let(:job) { create :job }

      before { sign_in user }

      it 'fails to delete job' do
        delete api_admin_v1_job_path(job.id)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when no user authenticated' do
      let(:job) { create :job }

      it 'fails to delete job' do
        delete api_admin_v1_job_path(job.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
