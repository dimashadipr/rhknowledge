# frozen_string_literal: true

class EventsController < WebController
  def index; end

  def event_calendar
    events = Event.search(params)
    recurring_events = RecurringEvent.active(params[:start], params[:end])
    list = events.map { |e| { title: e.title, start: e.start_date.to_time, end: e.end_date.to_time } }
    list += recurring_events
    render json: list
  end
end
