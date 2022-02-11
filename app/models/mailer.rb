# frozen_string_literal: true

# == Schema Information
#
# Table name: mailers
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  status     :string
#  subject    :string
#  slug       :string
#  content    :text
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Mailer < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  has_many :mailer_recipients

  def send?
    return true if status == 'submitted'

    false
  end

  def sent?
    return true if %w[sent failed invalid].include?(status)

    false
  end
end
