# == Schema Information
#
# Table name: translations
#
#  id            :bigint           not null, primary key
#  lang          :string
#  resource_type :string
#  resource_id   :integer
#  column        :string
#  content       :text
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Translation < ApplicationRecord
  acts_as_paranoid
end
