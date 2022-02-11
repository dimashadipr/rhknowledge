# frozen_string_literal: true

class Admin::NetworksController < AdminController
  before_action :prepare_network, only: %i[edit update destroy]

  def index
    authorize! :read, 'network'

    @networks = Network.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    authorize! :create, 'network'

    @network = Network.new
  end

  def create
    authorize! :create, 'network'

    @network = Network.new network_params

    if @network.save!
      flash[:success] = 'Success Add New Network'
    else
      flash[:error] = 'Failed to Add New Network'
    end

    redirect_to admin_networks_path
  end

  def edit
    authorize! :update, 'network'

  end

  def update
    authorize! :update, 'network'

    if @network.update network_params
      flash[:success] = 'Success Update Network'
      redirect_to admin_networks_path
    else
      flash[:error] = 'Failed to Update Network'
      render :edit
    end
  end

  def destroy
    authorize! :delete, 'network'

    if @network.destroy!
      flash[:success] = 'Success Delete Network'
    else
      flash[:error] = 'Failed Delete Network'
    end
    redirect_to admin_networks_path
  end

  private

  def network_params
    params[:network].permit(:name, :description, :logo ,:url)
  end

  def prepare_network
    @network = Network.find params[:id]
  end
end
