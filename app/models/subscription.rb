# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id          :bigint           not null, primary key
#  first_name  :string
#  last_name   :string
#  email       :string
#  institution :string
#  active      :boolean          default("true")
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Subscription < ApplicationRecord
  acts_as_paranoid
end
