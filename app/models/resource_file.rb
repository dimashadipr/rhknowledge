# == Schema Information
#
# Table name: resource_files
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  file              :string
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class ResourceFile < ApplicationRecord
  acts_as_paranoid

  belongs_to :page_file, class_name: 'PageFile', foreign_key: 'page_component_id'

  mount_uploader :file, ResourceFileUploader

end
