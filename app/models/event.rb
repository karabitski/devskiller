# frozen_string_literal: true

class Event < ApplicationRecord
  # extend Enumerize
  validates :employee_id, presence: true, numericality: true
  validates :timestamp, presence: true
  validates :kind, presence: true
  # enumerize :kind, in: { in: 0, out: 1 }
  # validates :kind, required: true  # validation inside enumerize

  scope :between, ->(start_date, end_date) { where(timestamp: start_date.beginning_of_day..end_date.end_of_day) }
  scope :for_employee, -> (id) { where employee_id: id }

  def self.modify_timestamp_and_save!(params)
    attrs = params.merge(timestamp: Time.at(params[:timestamp].to_i))
    attrs = params.merge(kind: (params[:kind] == 'in' : 0 : 1))
    create! attrs
  end

end
