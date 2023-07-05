# frozen_string_literal: true

class Event < ApplicationRecord
  validates :employee_id, presence: true, numericality: true
  validates :timestamp, presence: true
  validates :kind, presence: true

  scope :between, ->(start_date, end_date) { where(timestamp: start_date.beginning_of_day..end_date.end_of_day) }
  scope :for_employee, -> (id) { where employee_id: id }

  def self.modify_timestamp_and_save!(params)
    attrs = params.merge(timestamp: Time.at(params[:timestamp].to_i))
    kind = 0 if params[:kind].to_s == 'in'
    kind = 1 if params[:kind].to_s == 'out'
    attrs.merge!(kind: kind)
    create! attrs
  end

end
