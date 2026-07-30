# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      include Sanitizers::Profile::ProfileSanitizer
      def show
        profile = current_user.profile
        return render json: { error: 'Profile not found' }, status: :not_found unless profile
        render json: ProfileSerializer.render(profile), status: :ok
      end

      def update
        profile = current_user.profile
        return render json: { error: 'profile not found' }, status: :not_found unless profile

        if profile.update(profile_params)
          render json: ProfileSerializer.render(profile), status: :ok
        else
          render json: { errors: profile.errors.full_messages }, status: :unprocessable_content
        end
      end
    end
  end
end
