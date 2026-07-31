# frozen_string_literal: true

module Api
  module Admin
    module V1
      class JobApplicationsController < BaseController
        include Sanitizers::JobApplication::JobApplicationSanitizer
        before_action :set_job_application, only: %i[ show update destroy ]

        def index
          applications = JobApplication
            .includes(:user, :job)
            .with_attached_resume
            .with_attached_cover_letter

          render json: JobApplicationSerializer.render(applications), status: :ok
        end

        def show
          render json: JobApplicationSerializer.render(@job_applications), status: :ok
        end

        def update
          unless JobApplication.statuses.key?(status_params[:status])
            return render json: { errors: { status: 'is not a valid status' } }, status: :unprocessable_content
          end

          if @job_application.update(status_params)
            render json: JobApplicationSerializer.render(@job_application), status: :ok
          else
            render json: @job_application.errors, status: :unprocessable_content
          end
        end

        def destroy
          @job_application.destroy
          render json: JobApplicationSerializer.render(@job_application), status: :ok
        end

        private

        def status_params
          params.expect(job_application: [ :status ])
        end

        def set_job_application
          @job_application = JobApplication.find_by(id: params[:id])
          return if @job_application

          render json: { errors: 'Job application not found' }, status: :not_found
        end
      end
    end
  end
end
