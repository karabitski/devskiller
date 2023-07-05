# frozen_string_literal: true

class EventsController < ApplicationController
  def create
    begin
      event = Event.modify_timestamp_and_save! events_params
      render json: event
    rescue ActiveRecord::RecordInvalid, ActionController::ParameterMissing => e
      render json: { result: '400 Bad Request' }, status: 400
    end
  end

  private

  def events_params
    params.permit(:employee_id, :timestamp, :kind)
  end
end
