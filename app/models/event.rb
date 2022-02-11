# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  title       :string
#  description :string
#  location    :string
#  start_date  :datetime
#  end_date    :datetime
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
  acts_as_paranoid

  scope :by_start_end, lambda { |start_date, end_date|
    return where(nil) if start_date.blank? || end_date.blank?

    where('start_date >= ? and end_date <= ?', start_date, end_date)
  }

  def self.search(params)
    by_start_end(params[:start], params[:end])
  end

  def all_day?
    start_date.day == end_date.day
  end

  def active?
    now = DateTime.now.to_date

    return start_date.to_date == now if all_day?

    start_date.to_date < now && now < end_date.to_date
  end

  def passed?
    now = DateTime.now.to_date

    end_date < now
  end

  def upcoming?
    now = DateTime.now.to_date

    now < start_date
  end

  def status
    if active?
      'active'
    elsif passed?
      'passed'
    elsif upcoming?
      'upcoming'
    end
  end
end
