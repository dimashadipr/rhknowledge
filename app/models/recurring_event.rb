# frozen_string_literal: true

# == Schema Information
#
# Table name: recurring_events
#
#  id           :bigint           not null, primary key
#  user_id      :bigint
#  category     :string
#  name         :string
#  day_number   :integer
#  day_date     :integer
#  month_number :integer
#  active_until :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class RecurringEvent < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  def self.active(start_date, end_date)
    start_date = start_date.to_datetime
    end_date = end_date.to_datetime
    list = []
    (start_date..end_date).each do |date|
      day_number = date.wday
      weekly     = where(category: 'weekly').where(day_number: day_number)
      list += create_date(weekly, date)

      day_date = date.day
      monthly  = where(category: 'monthly').where(day_date: day_date)
      list += create_date(monthly, date)

      month_number = date.month
      yearly       = where(category: 'yearly').where(month_number: month_number).where(day_date: day_date)
      list += create_date(yearly, date)
    end

    list
  end

  def time
    case category
    when 'weekly'
      day = Date::DAYNAMES[day_number]
      "Every Week on #{day}"
    when 'monthly'
      "Every Month on #{day_date}"
    when 'yearly'
      month = Date::MONTHNAMES[month_number]
      "Every Year on #{day_date} #{month}"
    else
      'Undefined'
    end
  end

  private

  def self.create_date(list, date)
    list.map do |l|
      { title: l.name, start: date.to_time, end: date.to_time }
    end
  end
end
