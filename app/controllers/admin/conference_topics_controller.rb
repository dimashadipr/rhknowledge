# frozen_string_literal: true

class Admin::ConferenceTopicsController < AdminController
  def select_options
    topics = ConferenceTopic.search(params)

    result = topics.map { |e| {id: e.id, name: e.name} }

    render json: result
  end
end
