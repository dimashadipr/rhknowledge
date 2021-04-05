module Admin
  module Participant
    class FinalReviewer
      attr_reader :participant, :params, :current_user

      def initialize(participant, params, current_user)
        @participant  = participant
        @params       = params
        @current_user = current_user
      end

      def perform
        # get latest_abstract_file
        # update status abstract_file
        latest_abstract_file.status = params[:status]
        latest_abstract_file.save!
        # add log

        message = "Update Abstract File Status #{params[:status].humanize}"
        Admin::Participant::Logger.new(participant, message, params, current_user , 1, {}, latest_abstract_file).perform

        true
      end

      def latest_abstract_file
        @latest_abstract_file ||= participant.latest_abstract_file
      end
    end
  end
end
