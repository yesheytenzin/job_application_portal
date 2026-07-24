# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1:Auth:Registrations", type: :request do
  let!(:user) { create(:user) }

  describe "POST /api/v1/auth/sign_up" do
    context "with valid credentials" do
      subject(:sign_up_request) do
        post user_registration_path, params: { user: valid_user_params }
        response
      end

      let(:valid_user_params) { attributes_for(:user) }

      it "test registration" do
        sign_up_request
        expect(response).to have_http_status(:created)
        expect(json[:user][:email]).to eq valid_user_params[:email]
      end
    end

    context "with invalid credentials" do
      subject(:sign_up_request) do
        post user_registration_path, params: { user: invalid_user_params }
        response
      end

      let(:invalid_user_params) {
        {
          user: {
            email: Faker::Internet.email,
            password: Faker::Internet.password(min_length: 8),
            password_confirmation: Faker::Internet.password(min_length: 8)
          }
        }
      }

      it "test registration fail" do
        sign_up_request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
