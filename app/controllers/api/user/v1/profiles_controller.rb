# frozen_string_literal: true

module Api
  module User
    module V1
      class ProfilesController < BaseController
        include Sanitizers::Profile::ProfileSanitizer

        def show
          return render json: { error: 'Profile not found' }, status: :not_found unless profile
          render json: ProfileSerializer.render(profile), status: :ok
        end

        def update
          if update_profile.update(profile_params)
            render json: ProfileSerializer.render(update_profile), status: :ok
          else
            render json: { errors: update_profile.errors.full_messages }, status: :unprocessable_content
          end
        end

        private

        def profile
          @profile ||= current_user.profile
        end

        def update_profile
          @profile ||= current_user.profile || current_user.build_profile
        end
      end
    end
  end
end
