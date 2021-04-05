# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user, :permissions

  def initialize(user)
    @user        = user || User.new
    @permissions = @user.permissions
  end

  def can?(action, subject, *extra_args)
    can_manage_all? || authorized?(action, subject, *extra_args) || super
  end

  def authorize!(action, subject, *args)
    unless authorized?(action, subject, *args)
      message ||= unauthorized_message(action, subject)
      raise CanCan::AccessDenied.new(message, action, subject)

      super
    end
  end

  def authorized?(action, subject, *args)
    authorizeds = [subject].flatten.map do |subject|
      permitted = can_manage_all? || permissions.find { |permission| permission.action.strip == permission_action(action, subject).strip }

      if permitted && subject.is_a?(ActiveRecord::Base)
        # e.g: [{status: 'draft'}]
        args.each do |arg|
          arg.each do |k, v|
            permitted = false and break unless subject.send(k) == v
          end
        end
      end

      permitted
    end

    authorizeds.all?
  end

  private

  def can_manage_all?
    !permissions.find { |permission| permission.action == 'system.manage' }.blank?
  end

  def permission_action(action, subject)
    [normalize_subject(subject), normalize_action(action)].join('.')
  end

  def normalize_action(action)
    action.to_s.underscore
  end

  def normalize_subject(subject)
    return subject.to_s.underscore if subject.is_a?(String) || subject.is_a?(Class)

    klass = subject.try(:type) ? subject.class.base_class : subject.class
    klass.name.underscore
  end
end
