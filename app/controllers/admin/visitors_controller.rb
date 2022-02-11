# frozen_string_literal: true

class Admin::VisitorsController < AdminController
  def index
    @ahoy_visits = Ahoy::Visit.select('visitor_token').group(:visitor_token)
    @visitors = Kaminari.paginate_array(@ahoy_visits).page(params[:page]).per(10)
  end

  def detail_visitor_token
    @visitor_token = params[:visitor_token]
    @ahoy_visits = Ahoy::Visit.where(visitor_token: params[:visitor_token])
                              .order(started_at: :asc)
                              .page(params[:page])
                              .per(10)
    @ahoy_events = Ahoy::Event.where(visit_id: @ahoy_visits.map(&:id))
                              .order(time: :asc)
                              .page(params[:event_page])
                              .per(15)
  end
end
