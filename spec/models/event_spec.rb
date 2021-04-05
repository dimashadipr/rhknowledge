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
require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
