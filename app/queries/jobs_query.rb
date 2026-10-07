# frozen_string_literal: true

class JobsQuery < BaseQuery
  def query
    scope = base_scope
    scope = apply_search(scope)
    scope = filter_by_status(scope)
    scope = apply_salary_filter(scope)
  end

  private

  def base_scope
    Job.includes(:user)
  end

  def apply_search(scope)
    return scope if params[:q].blank?
    scope.ransack(title: params[:q]).result(distinct: true)
  end

  def filter_by_status(scope)
    return scope if params[:status].blank?
    scope.where(status: params[:status])
  end

  def apply_salary_filter(scope)
    scope = scope.where('min_salary >= ?', params[:min_salary]) if params[:min_salary].present?
    scope = scope.where('max_salary <= ?', params[:max_salary]) if params[:max_salary].present?
    scope
  end
end
