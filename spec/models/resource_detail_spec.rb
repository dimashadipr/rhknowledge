# == Schema Information
#
# Table name: resource_details
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  source_id         :bigint
#  image             :string
#  content           :text
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  navigation_id     :bigint
#
require 'rails_helper'

RSpec.describe ResourceDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
