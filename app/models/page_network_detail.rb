# frozen_string_literal: true

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
class PageNetworkDetail < ApplicationRecord
  acts_as_paranoid
end
