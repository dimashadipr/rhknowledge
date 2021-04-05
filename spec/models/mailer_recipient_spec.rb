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
require 'rails_helper'

RSpec.describe MailerRecipient, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
