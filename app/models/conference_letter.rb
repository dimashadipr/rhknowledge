# == Schema Information
#
# Table name: conference_letters
#
#  id            :bigint           not null, primary key
#  conference_id :bigint
#  name          :string
#  title         :string
#  message       :string
#  image         :string
#  position      :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ConferenceLetter < ApplicationRecord
  acts_as_paranoid
  
  mount_uploader :image, ImageUploader
end
