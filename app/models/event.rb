# frozen_string_literal: true

class Event < ApplicationRecord
  validates :employee_id, presence: true, numericality: true
  validates :timestamp, presence: true
  validates :kind, presence: true
  enum :kind, { in: 0, out: 1 }

  scope :between, ->(start_date, end_date) { where(timestamp: start_date.beginning_of_day..end_date.end_of_day) }
  scope :for_employee, -> (id) { where employee_id: id }

  def self.modify_timestamp_and_save!(params)
    attrs = params.merge(timestamp: Time.at(params[:timestamp].to_i))
    create! attrs
  end
end
