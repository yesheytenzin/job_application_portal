# frozen_string_literal: true

class JobApplicationsQuery < BaseQuery
  def query
    scope = base_scope
    scope = apply_search(scope)
    scope = filter_by_status(scope)
  end

  private

  def base_scope
    current_user.job_applications
                .includes(:job)
                .with_attached_resume
                .with_attached_cover_letter
  end

  def apply_search(scope)
    return scope if params[:q].blank?
    scope.ransack(job_title_count: params[:q]).result(distinct: true)
  end

  def filter_by_status(scope)
    return scope if params[:status].blank?
    scope.where(status: params[:status])
  end
end
