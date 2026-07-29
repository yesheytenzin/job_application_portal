# frozen_string_literal: true

class Api::V1::JobsController < ApplicationController
  include Sanitizers::Job::JobSanitizer
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :check_admin!, except: [ :index, :show ]

  def index
    render json: JobSerializer.render(Job.all), status: :ok
  end

  def show
    return render json: { error: 'Job not found' }, status: :not_found unless job
    render json: JobSerializer.render(job), status: :ok
  end

  def create
    job = Job.new(job_params)
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
      render json: JobSerializer.render(job), status: :ok
    else
      render json: job.errors, status: :unprocessable_content
    end
  end

  private

  def job
    @job ||= Job.find_by(id: params[:id])
  end

  helper_method :job

  def check_admin!
    return if current_user.admin?
    render json: { error: 'Access denied: Admin privileges required' }, status: :forbidden
  end
end
