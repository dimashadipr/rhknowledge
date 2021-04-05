# frozen_string_literal: true

# == Schema Information
#
# Table name: inquiries
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  message    :text
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Inquiry < ApplicationRecord
  acts_as_paranoid
end
