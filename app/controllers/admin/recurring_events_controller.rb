# frozen_string_literal: true

class Admin::RecurringEventsController < AdminController
  before_action :prepare_recurring_event, only: %i[edit update destroy]
  before_action :prepare_data, only: [:edit]

  def create
    authorize! :create, 'event'

    @event = RecurringEvent.new event_params
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
      flash[:success] = 'Success Add New Event'
      redirect_to admin_events_path
    else
      flash[:error] = 'Failed to Add New Event'
      render :edit
    end
  end

  def destroy
    authorize! :delete, 'event'

    if @recurring_event.destroy!
      flash[:success] = 'Success Delete Recurring Event'
    else
      flash[:error] = 'Failed Delete Recurring Event'
    end
    redirect_to admin_events_path
  end

  private

  def prepare_data
    @repeat_options = %w[weekly monthly yearly].map { |e| [e.humanize, e] }
    @day_options = []
    @date_options = (1..31)
    @month_options = []
    Date::DAYNAMES.each_with_index { |x, i| @day_options << [x, i] }
    (1..12).each { |m| @month_options << [Date::MONTHNAMES[m], m] }
  end

  def prepare_recurring_event
    @recurring_event = RecurringEvent.find params[:id]
  end

  def event_params
    params[:recurring_event][:user_id] = current_user.id

    params[:recurring_event].permit(:name, :description, :category, :user_id,
                                    :day_number, :day_date, :month_number)
  end
end
