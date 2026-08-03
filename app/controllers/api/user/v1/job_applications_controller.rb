# frozen_string_literal: true

module Api
  module User
    module V1
      class JobApplicationsController < BaseController
        include Sanitizers::JobApplication::JobApplicationSanitizer

        before_action :set_job_application, only: %i[ show ]

        def index
          applications = JobApplicationsQuery.new(
            params: params,
            current_user: current_user
          ).query

          render json: paginate(
            applications,
            JobApplicationSerializer,
            :job_applications
          ), status: :ok
        end

        def show
          render json: JobApplicationSerializer.render(@job_application), status: :ok
        end

        def create
          application = current_user.job_applications.new(job_application_params)

          if application.save
            render json: JobApplicationSerializer.render(application), status: :created
          else
            render json: application.errors, status: :unprocessable_content
          end
        end

        private

        def set_job_application
          @job_application = current_user.job_applications.find_by(id: params[:id])
          return if @job_application

          render json: { errors: 'Job application not found' }, status: :not_found
        end
      end
    end
  end
end
