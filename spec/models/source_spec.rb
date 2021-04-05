# == Schema Information
#
# Table name: sources
#
#  id           :bigint           not null, primary key
#  name         :string
#  code         :string
#  image_header :string
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Source, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
