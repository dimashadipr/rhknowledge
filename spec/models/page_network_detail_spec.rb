# == Schema Information
#
# Table name: page_network_details
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  logo              :string
#  name              :string
#  description       :string
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe PageNetworkDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
