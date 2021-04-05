# == Schema Information
#
# Table name: networks
#
#  id          :bigint           not null, primary key
#  logo        :string
#  name        :string
#  description :string
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  url         :string
#
require 'rails_helper'

RSpec.describe Network, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
