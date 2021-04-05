# == Schema Information
#
# Table name: banners
#
#  id         :bigint           not null, primary key
#  image      :string
#  label      :string
#  sublabel   :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Banner, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
