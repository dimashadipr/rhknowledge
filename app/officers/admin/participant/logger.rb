# frozen_string_literal: true

module Admin
  module Participant
    class Logger
      def initialize(participant, message, params, current_user = nil, public = 0, data = {}, klass = nil)
        @participant  = participant
        @message      = message
        @params       = params
        @current_user = current_user
        @public       = public
        @data         = data
        @klass        = klass
      end

      def perform
        log             = ParticipantLog.new
        log.participant = @participant
        log.message     = @message
        log.params      = @params
        log.data        = @data
        log.resource    = @klass
        log.user        = @current_user
        log.public      = @public
        log.save
      end
    end
  end
end
