# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :validate_params, only: :get
  def get
    begin
      render json: ReportGenerator.build(params[:employee_id], params[:from], params[:to])
    rescue
      render json: { result: 'App error' }, status: 500
    end
  end

  private

  def validate_params
    to_date_valid = !!Date.parse(params[:to]) rescue false
    from_date_valid = !!Date.parse(params[:from]) rescue false
    valid_id = params[:employee_id].to_i > 0
    return if to_date_valid && from_date_valid && valid_id

    render json: { errors: 'Bad params' }, status: 400
  end
end
