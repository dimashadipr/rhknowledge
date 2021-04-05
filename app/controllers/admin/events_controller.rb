# frozen_string_literal: true

class Admin::EventsController < AdminController
  before_action :prepare_event, only: %i[edit update destroy]
  before_action :prepare_data, only: %i[new edit]

  def index
    authorize! :read, 'event'

    @events = Event.search(params)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(25)
    @recurring_events = RecurringEvent.order(created_at: :desc)
                                      .page(params[:page])
                                      .per(25)
  end

  def new
    authorize! :create, 'event'

    @event = Event.new
    @recurring_event = RecurringEvent.new
  end

  def create
    authorize! :create, 'event'

    @event = Event.new event_params
    if @event.save!
      flash[:success] = 'Success Add New Event'
    else
      flash[:error] = 'Failed to Add New Event'
    end

    redirect_to admin_events_path
  end

  def edit
    authorize! :update, 'event'
  end

  def update
    authorize! :update, 'event'

    if @event.update event_params
      flash[:success] = 'Success Update Event'
      redirect_to admin_events_path
    else
      flash[:error] = 'Failed to Update Event'
      render :edit
    end
  end

  def destroy
    authorize! :delete, 'event'

    if @event.destroy!
      flash[:success] = 'Success Delete Event'
    else
      flash[:error] = 'Failed Delete Event'
    end
    redirect_to admin_events_path
  end

  private

  def prepare_event
    @event = Event.find params[:id]
  end

  def prepare_data
    @repeat_options = %w[weekly monthly yearly].map { |e| [e.humanize, e] }
    @day_options = []
    @date_options = (1..31)
    @month_options = []
    Date::DAYNAMES.each_with_index { |x, i| @day_options << [x, i] }
    (1..12).each { |m| @month_options << [Date::MONTHNAMES[m], m] }
  end

  def event_params
    params[:event][:user_id] = current_user.id
    params[:event].permit(:title, :description, :start_date, :end_date, :user_id)
  end
end
