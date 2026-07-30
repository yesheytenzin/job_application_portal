# frozen_string_literal: true

module Sanitizers
  module Profile
    module ProfileSanitizer
      private

      def profile_params
        params.expect(profile: [ :first_name, :last_name, :username, :phone, :address ])
      end
    end
  end
end
