# frozen_string_literal: true

class Admin::NavigationsController < AdminController
  before_action :prepare_data, only: %i[new edit]
  before_action :prepare_navigation, only: %i[edit update destroy]

  def index
    authorize! :read, 'navigation'
    @navigations = Navigation.where(level: 1)
                             .order(navigation_id: :desc)
                             .order(position: :asc)
                             .page(params[:page])
                             .per(15)
  end

  def new
    authorize! :create, 'navigation'

    @navigation = Navigation.new
  end

  def show
    authorize! :read, 'navigation'

    @navigations = Navigation.where(navigation_id: params[:id])
                             .order(position: :asc)
                             .page(params[:page])
                             .per(15)
  end

  def edit
    authorize! :update, 'navigation'
  end

  def create
    authorize! :create, 'navigation'

    ActiveRecord::Base.transaction do
      navigation = Navigation.new(navigation_params)
      if navigation.save
        flash[:success] = 'Success Create Navigation'
      else
        flash[:error] = 'Failed Create Navigation'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_navigations_path
  end

  def update
    authorize! :update, 'navigation'

    ActiveRecord::Base.transaction do
      if @navigation.update navigation_params
        flash[:success] = 'Success Update Navigation'
      else
        flash[:error] = 'Failed Update Navigation'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_navigations_path
  end

  def destroy
    authorize! :destroy, 'navigation'

    if @resource_page.destroy!
      flash[:success] = 'Success Delete Page'
    else
      flash[:error] = 'Failed Delete Page'
    end
    redirect_to admin_resources_path
  end

  def tree_data
    parents = Navigation.preload(:childrens).parent_nav

    render json: parents.map(&:to_node)
  end

  private

  def prepare_navigation
    @navigation = Navigation.find(params[:id])
  end

  def prepare_data
    @parent_list = Navigation.where.not(level: 3)
                             .where('navigations.editable = ?', true)
                             .map do |nav|
      parent_title = nav.parent&.title
      title = nav.title
      case nav.level
      when 1
        text = "<b>#{title}</b>"
      when 2
        text = "&nbsp; #{nav.level}.&nbsp;<b>#{parent_title}</b> - #{title}"
      when 3
        text = "&nbsp;&nbsp;&nbsp;#{nav.level}.&nbsp;<b>#{parent_title}</b> - #{title}"
      end

      [text, nav.id]
    end
    @pages = Page.where.not(type: 'Homepage').map { |e| [e.title, e.id] }
  end

  def navigation_params
    parent = Navigation.find params[:navigation][:navigation_id]

    level = 1

    code = if parent.present?
             "#{parent.title.parameterize}-#{params[:navigation][:title].parameterize}"
           else
             params[:navigation][:title].parameterize.to_s
           end

    # generate level
    level = parent.level + 1 if parent.present?

    params[:navigation][:code] = code
    params[:navigation][:level] = level

    params[:navigation].permit(:title, :position, :navigation_id, :page_id, :code, :tooltip, :level)
  end
end
