# frozen_string_literal: true

class SubscriptionsController < WebController
  def create
    if !exist
      subscription = Subscription.new create_params
    else
      subscription = exist
      subscription.attributes = create_params
    end
    @class = if subscription.save && verify_recaptcha
               'success'
             else
               'danger'
             end
  rescue StandardError => e
    @class = 'danger'
    respond_to do |format|
      format.js
    end
  end

  private

  def exist
    Subscription.find_by(email: create_params[:email])
  end

  def create_params
    params[:subscriptions].permit(:first_name, :last_name, :email, :institution)
  end
end
