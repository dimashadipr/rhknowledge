# frozen_string_literal: true

class Admin::HomeController < AdminController
  def index
    past_date = DateTime.now - 7.days

    @resources = ResourcePage.order(created_at: :desc)
    @events    = Event.order(created_at: :desc)
    @visits    = Ahoy::Visit.distinct.count('visitor_token')
    @visitors  = Ahoy::Visit.where('started_at > ?', past_date)
                            .group_by(&:visitor_token)

    @participants = Participant.order(created_at: :desc)
    @abstracts    = @participants.select { |p| p.abstract_file.present? }
  end
end
