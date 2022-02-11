# frozen_string_literal: true

class Admin::ResourcesController < AdminController
  before_action :prepare_data, only: %i[index new edit]
  before_action :prepare_page, only: %i[edit update destroy]

  def index
    authorize! :read, 'resource'

    params[:search] = {} if params[:search].blank?

    @resource_pages = ResourcePage.preload(page_content: [resource_detail: %i[navigation taggings]])
                                  .search(params[:search])
                                  .order(created_at: :desc)
                                  .page(params[:page])
                                  .per(15)
  end

  def new
    authorize! :create, 'resource'

    @resource_page = ResourcePage.new
  end

  def create
    authorize! :create, 'resource'

    ActiveRecord::Base.transaction do
      officer = ResourceOfficer.new(resource_params, current_user)
      if officer.perform
        flash[:success] = 'Success Create Resource Page'
      else
        flash[:error] = 'Failed Create Resource Page'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_resources_path
  end

  def edit
    authorize! :update, 'resource'
  end

  def update
    authorize! :update, 'resource'

    ActiveRecord::Base.transaction do
      officer = ResourceOfficer.new(params[:resources].merge(id: params[:id]), current_user)
      if officer.perform
        flash[:success] = 'Success Update Resource Page'
      else
        flash[:error] = 'Failed Update Resource Page'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_resources_path
  end

  def destroy
    authorize! :delete, 'resource'

    if @resource_page.destroy!
      flash[:success] = 'Success Delete Page'
    else
      flash[:error] = 'Failed Delete Page'
    end
    redirect_to admin_resources_path
  end

  def counter
    ahoy_events = Ahoy::Event.where(name: 'Viewed articles#show_page')
    grouped = ahoy_events.group_by { |ae| ae.properties['slug'] }
    grouped = grouped.sort_by { |e| e[1].size }.reverse!
    @visitors = Kaminari.paginate_array(grouped).page(params[:page]).per(10)
  end

  private

  def prepare_page
    @resource_page = ResourcePage.find params[:id]
  end

  def prepare_data
    @navigation_options ||= begin
      main_nav = Navigation.preload(:parent)
                           .eager_load(:childrens)
                           .where(level: [1, 2])
                           .where(childrens_navigations: { id: nil })
                           .where('navigations.editable = ?', true)

      level3 = Navigation.preload(:parent)
                         .where(level: 3)
                         .where(editable: true)

      navigations = level3 + main_nav
      navigations.map { |e| ["#{e.parent&.title}- #{e.title}", e.id] }
      navigations.map do |nav|
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
    end
  end

  def resource_params
    params[:resources].permit(:navigation_id, :title, :image, :content, tag_list: [], files: [])
  end
end
