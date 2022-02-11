# frozen_string_literal: true

class Admin::SubscriptionsController < AdminController
  before_action :prepare_subscription, only: [:change_status]

  def index
    authorize! :read, 'subscription'

    @subscriptions = Subscription.page(params[:page])
                                 .per(25)
  end

  def change_status
    authorize! :update, 'subscription'
    if @subscription.active
      @subscription.active = false
      flash[:success] = "Success Inactive #{@subscription.email}"
    else
      @subscription.active = true
      flash[:success] = "Success Activate #{@subscription.email}"
    end

    @subscription.save

    redirect_back(fallback_location: admin_subscriptions_path)
  end

  private

  def prepare_subscription
    @subscription = Subscription.find params[:id]
  end
end
