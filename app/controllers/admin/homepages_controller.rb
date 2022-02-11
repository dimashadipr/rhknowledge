# frozen_string_literal: true

class Admin::HomepagesController < AdminController
  before_action :prepare_page

  def index
    authorize! :read, 'homepage'

  end

  def update
    authorize! :update, 'homepage'

    ActiveRecord::Base.transaction do
      officer = HomepageOfficer.new(@homepage, params[:homepage])
      if officer.perform
        flash[:success] = 'Success Update Homepage'
      else
        flash[:error] = 'Failed Update Homepage'
      end
    end

    redirect_to admin_homepages_path
  end

  private

  def prepare_page
    @homepage     = Page.find_by slug: 'homepage'
    @link_options = Page.where.not(type: 'Homepage').map { |e| [e.title, e.id] }
  end

  def homepage_params
    params[:homepage].permit(:title, page_banners: {}, page_networks: {})
  end
end
