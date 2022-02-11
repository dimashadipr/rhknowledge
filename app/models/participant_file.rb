# frozen_string_literal: true

# == Schema Information
#
# Table name: participant_files
#
#  id             :bigint           not null, primary key
#  participant_id :bigint
#  type           :string
#  file           :string
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :string
#  data           :jsonb
#
class ParticipantFile < ApplicationRecord
  acts_as_paranoid

  mount_uploader :file, FileUploader

  belongs_to :participant

  has_many :participant_file_reviews

  scope :by_status, lambda { |status|
    return where nil if status.blank?

    status.downcase!
    status.strip!

    where('lower(status) = ?', status)
  }

  def self.search(params)
    by_status(params[:status])
  end

  def extension
    file.file.extension
  end
end
