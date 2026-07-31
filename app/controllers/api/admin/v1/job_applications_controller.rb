# frozen_string_literal: true

module Api
  module Admin
    module V1
      class JobApplicationsController < BaseController
        # include Sanitizers::Job::JobSanitizer
        #
        # def index
        #   jobs = ::JobsQuery.new(params: params, current_user: current_user).query
        #   render json: paginate(jobs, JobSerializer, :jobs), status: :ok
        # end
        #
        # def show
        #   return render json: { error: 'Job not found' }, status: :not_found unless job
        #   render json: JobSerializer.render(job), status: :ok
        # end
        #
        # private
        #
        # def job
        #   @job ||= ::Job.find_by(id: params[:id])
        # end
        #
        # helper_method :job
      end
    end
  end
end
