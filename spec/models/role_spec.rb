# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  type       :string
#  code       :string
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
