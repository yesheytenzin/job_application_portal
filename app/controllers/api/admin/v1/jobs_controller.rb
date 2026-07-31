# frozen_string_literal: true

module Api
  module Admin
    module V1
      class JobsController < BaseController
        include Sanitizers::Job::JobSanitizer

        def create
          job = ::Job.new(job_params)
          job.user = current_user

          if job.save
            render json: JobSerializer.render(job), status: :created
          else
            render json: job.errors, status: :unprocessable_content
          end
        end

        def update
          if job.update(job_params)
            render json: JobSerializer.render(job), status: :ok
          else
            render json: job.errors, status: :unprocessable_content
          end
        end

        def destroy
          if job.destroy
            render json: JobSerializer.render(job), status: :no_content
          else
            render json: job.errors, status: :unprocessable_content
          end
        end

        private

        def job
          @job ||= ::Job.find_by(id: params[:id])
        end

        helper_method :job
      end
    end
  end
end
