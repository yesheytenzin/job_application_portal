# frozen_string_literal: true

module Api
  module V1
    class JobApplicationsController < ApplicationController
      include Sanitizers::JobApplication::JobApplicationSanitizer

      before_action :authenticate_user!
      before_action :set_job_application, only: %i[ show update destroy ]
      before_action :check_admin!, only: %i[ update destroy ]

      def index
        applications =
          if current_user.admin?
            JobApplication.includes(:user, :job)
          else
            current_user.job_application.include(:job)
          end

        render json: JobApplicationSerializer.render(applications), status: :ok
      end

      def show
        unless current_user.admin? || @job_application.user == current_user
          render json: { errors: 'Access denied' }, status: :forbidden
        end

        render json: JobApplicationSerializer.render(@job_application)
      end

      def create
        application = current_user.job_application.new(job_application_params)
        application.status = JobApplication::SUBMITTED

        if application.save
          render json: JobApplicationSerializer.render(@job_application), status: :ok
        else
          render json: @job_application.errors, status: :unprocessable_content
        end
      end

      def update
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

      def set_job_application
        @job_application = JobApplication.find_by(id: params[:id])
        return if @job_application

        render json: { errors: 'Job application not found' }, status: :not_found
      end

      def status_params
        params.expect(job_application: [ :status ])
      end

      def check_admin!
        return if current_user.admin?

        render json: {
          errors: 'Access denied: admin privileges required'
        }, status: :forbidden
      end
    end
  end
end
