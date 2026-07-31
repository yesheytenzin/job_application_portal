# frozen_string_literal: true

module Sanitizers
  module Job
    module JobSanitizer
      private

      def job_params
        params.expect(job: [ :title, :description, :min_salary, :max_salary, :status, { attachements: [] } ])
      end
    end
  end
end
