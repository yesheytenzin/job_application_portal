# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Auth::Sessions', type: :request do
  let(:raw_password) { Faker::Internet.password(min_length: 8) }
  let!(:valid_user) { create(:user, password: raw_password, password_confirmation: raw_password) }

  describe 'POST /api/v1/auth/sign_in' do
    context 'with valid credentials' do
      subject(:sign_in_request) do
        post user_session_path, params: { user: valid_user_params }
        response
      end

      let(:valid_user_params) { { email: valid_user.email, password: raw_password } }

      it 'for Login tests' do
        sign_in_request
        expect(response).to have_http_status(:ok)
        expect(json.with_indifferent_access['email']).to eq(valid_user_params[:email])
        expect(response.headers['Set-Cookie']).to be_present
      end
    end

    context 'with invalid credentials' do
      subject(:sign_in_request) do
        post user_session_path, params: { user: invalid_user_params }
        response
      end

      let(:invalid_user_params) { { email: Faker::Internet.email, password: Faker::Internet.password } }

      it 'login fail test' do
        sign_in_request
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/auth/sign_out' do
    subject(:sign_out_request) do
      post user_session_path, params: { user: valid_user_params }
      delete destroy_user_session_path
      response
    end

    let(:valid_user_params) { { email: valid_user.email, password: raw_password } }

    it 'for logout test' do
      sign_out_request
      expect(response).to have_http_status(:ok)
    end
  end
end
