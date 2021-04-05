# frozen_string_literal: true

class ContactsController < WebController
  def index; end

  def create
    inquiry = Inquiry.new create_params
    @class = if inquiry.save && verify_recaptcha
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

  def create_params
    params[:inquiry].permit(:name, :email, :message)
  end
end
