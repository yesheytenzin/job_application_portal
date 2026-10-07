# frozen_string_literal: true

module Sanitizers
  module JobApplication
    module JobApplicationSanitizer
      private

      def job_application_params
        params.expect(job_application: [ :job_id, :resume, :cover_letter ])
      end
    end
  end
end
