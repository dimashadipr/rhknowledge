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
require 'rails_helper'

RSpec.describe Mailer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
