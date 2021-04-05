class Admin::SourcesController < AdminController
  before_action :prepare_source, only: %i[edit update destroy]

  def index
    @sources = Source.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    @source = Source.new
  end

  def create
    @source = Source.new source_params

    if @source.save!
      flash[:success] = 'Success Add New Source'
    else
      flash[:error] = 'Failed to Add New Source'
    end

    redirect_to admin_sources_path
  end

  def edit; end

  def update
    if @source.update source_params
      flash[:success] = 'Success Update Source'
      redirect_to admin_sources_path
    else
      flash[:error] = 'Failed to Update Source'
      render :edit
    end
  end

  def destroy
    if @source.destroy!
      flash[:success] = 'Success Delete Source'
    else
      flash[:error] = 'Failed Delete Source'
    end
    redirect_to admin_sources_path
  end

  private

  def source_params
    params[:source].permit(:code, :name, :image_header)
  end

  def prepare_source
    @source = Source.find params[:id]
  end
end
