# == Schema Information
#
# Table name: conference_assets
#
#  id            :bigint           not null, primary key
#  conference_id :bigint
#  type          :string
#  image         :string
#  file          :string
#  label         :string
#  position      :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ConferenceBanner < ConferenceAsset
  acts_as_paranoid

  mount_uploader :file, ImageUploader
end
