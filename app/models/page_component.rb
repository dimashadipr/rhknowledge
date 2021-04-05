# frozen_string_literal: true

# == Schema Information
#
# Table name: page_components
#
#  id             :bigint           not null, primary key
#  page_id        :bigint
#  type           :string
#  position       :integer
#  reference_type :string
#  reference_id   :integer
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class PageComponent < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :page, touch: true
  belongs_to :reference, polymorphic: true, optional: true
end
