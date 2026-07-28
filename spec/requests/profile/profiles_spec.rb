# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Profiles', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create :user }

  describe 'GET /api/v1/profiles' do
    context 'when auth with a profile' do
      let!(:profile) { create :profile, user: user }

      before { sign_in user }

      it 'returns profile' do
        get api_v1_profile_path
        expect(response).to have_http_status(:ok)
        expect(json['id']).to eq(profile.id)
      end
    end

    context 'when auth with no profile' do
      before { sign_in user }

      it 'returns not found' do
        get api_v1_profile_path
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when unauthenticated' do
      it 'return 401' do
        get api_v1_profile_path
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/profiles' do
    context 'when auth with a profile' do
      let!(:profile) { create :profile, user: user }

      before { sign_in user }

      context 'with valid params' do
        let(:valid_params) { { profile: { first_name: 'john' } } }

        it 'updates the profile' do
          put api_v1_profile_path, params: valid_params
          expect(response).to have_http_status(:ok)
          expect(profile.reload.first_name).to eq('john')
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { { profile: { first_name: '' } } }

        it 'does not update the profile' do
          put api_v1_profile_path, params: invalid_params
          expect(response).to have_http_status(:unprocessable_content)
          expect(response.body).to include('First name can\'t be blank')
        end
      end
    end

    context 'when authenticated without a profile' do
      before { sign_in user }

      it 'returns 404' do
        put api_v1_profile_path, params: { profile: { first_name: 'X' } }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when unauthenticated' do
      it 'returns 401' do
        put api_v1_profile_path, params: { profile: { first_name: 'X' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
