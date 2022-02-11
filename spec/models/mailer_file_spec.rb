# == Schema Information
#
# Table name: mailer_files
#
#  id         :bigint           not null, primary key
#  mailer_id  :bigint
#  file       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe MailerFile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
