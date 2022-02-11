# frozen_string_literal: true

class Admin::InquiriesController < AdminController
  before_action :prepare_inquiry, only: [:show]

  def index
    authorize! :read, 'inquiry'

    @inquiries = Inquiry.page(params[:page])
                        .per(25)
  end

  def show
    authorize! :read, 'inquiry'
  end

  private

  def prepare_inquiry
    @inquiry = Inquiry.find params[:id]
  end
end
