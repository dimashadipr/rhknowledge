# == Schema Information
#
# Table name: pages
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  parent_id   :integer
#  type        :string
#  title       :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#  data        :jsonb
#  description :string
#
require 'rails_helper'

RSpec.describe Page, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
