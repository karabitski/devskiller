# frozen_string_literal: true

class ReportGenerator
  def self.build(employee_id, from, to)
    problematic_dates = []
    worktime_hrs = 0
    events = Event.between(Date.parse(from), Date.parse(to))
                  .for_employee(employee_id)
                  .order(timestamp: :desc)
    events.group_by{|e| e.timestamp.to_date.to_s }.each do |date, events|
      in_event = events.find{|e| e.kind == 'in'}
      out_event = events.find{|e| e.kind == 'out'}
      if events.count == 2 &&  in_event && out_event
        seconds = out_event.timestamp - in_event.timestamp
        hours = (seconds/3600.to_f).round(2)
        worktime_hrs += hours
      else
        problematic_dates << date
      end
    end
    result = {
      employee_id: employee_id.to_s,
      from: from,
      to: to,
      worktime_hrs: worktime_hrs,
      problematic_dates: problematic_dates
    }.to_json
  end
end
