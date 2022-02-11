# == Schema Information
#
# Table name: mailer_recipients
#
#  id         :bigint           not null, primary key
#  mailer_id  :bigint
#  email      :string
#  name       :string
#  status     :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  data       :jsonb
#
class MailerRecipient < ApplicationRecord
  acts_as_paranoid

  belongs_to :mailer

  def send?
    return true if status == 'submitted'

    false
  end

  def sent?
    return true if %w[sent failed invalid].include?(status)

    false
  end
end
