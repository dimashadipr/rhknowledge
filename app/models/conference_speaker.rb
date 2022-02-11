# == Schema Information
#
# Table name: conference_speakers
#
#  id                  :bigint           not null, primary key
#  conference_id       :bigint
#  name                :string
#  title               :string
#  image               :string
#  position            :integer
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  group               :string
#  conference_position :string
#
class ConferenceSpeaker < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, ImageUploader
end
