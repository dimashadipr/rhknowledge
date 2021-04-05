# frozen_string_literal: true

class Admin::BannersController < AdminController
  before_action :prepare_banner, only: %i[edit update destroy]

  def index
    @banners = Banner.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new banner_params

    if @banner.save!
      flash[:success] = 'Success Add New Banner'
    else
      flash[:error] = 'Failed to Add New Banner'
    end

    redirect_to admin_banners_path
  end

  def edit; end

  def update
    if @banner.update banner_params
      flash[:success] = 'Success Update Banner'
      redirect_to admin_banners_path
    else
      flash[:error] = 'Failed to Update Banner'
      render :edit
    end
  end

  def destroy
    if @banner.destroy!
      flash[:success] = 'Success Delete Banner'
    else
      flash[:error] = 'Failed Delete Banner'
    end
    redirect_to admin_banners_path
  end

  private

  def banner_params
    params[:banner].permit(:label, :sublabel, :image)
  end

  def prepare_banner
    @banner = Banner.find params[:id]
  end
end
