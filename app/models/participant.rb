# == Schema Information
#
# Table name: participants
#
#  id                        :bigint           not null, primary key
#  user_id                   :bigint
#  front_title               :string
#  back_title                :string
#  title                     :string
#  name                      :string
#  email                     :string
#  phone                     :string
#  institution               :string
#  institution_phone         :string
#  participant               :string
#  topic                     :string
#  abstract                  :string
#  deleted_at                :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  whatsapp                  :string
#  data                      :jsonb
#  slug                      :string
#  conference_id             :bigint
#  conference_participant_id :bigint
#  conference_topic_id       :bigint
#
class Participant < ApplicationRecord
  acts_as_paranoid

  mount_uploader :abstract, FileUploader

  belongs_to :conference_participant, optional: true
  belongs_to :conference_topic, optional: true

  has_many :participant_files, dependent: :destroy
  has_many :participant_logs, dependent: :destroy

  has_one :latest_abstract_file, -> { order(id: :desc) }, class_name: 'AbstractFile'
  has_one :paper_file, -> { order(id: :desc) }, class_name: 'PaperFile'
  has_one :payment_file, -> { order(id: :desc) }, class_name: 'PaymentFile'
  has_one :presentation_file, -> { order(id: :desc) }, class_name: 'PresentationFile'

  scope :by_query, lambda { |query|
    return where nil if query.blank?

    query.downcase!
    query.strip!

    where('lower(name) LIKE :query OR lower(email) LIKE :query OR lower(institution) LIKE :query', query: "%#{query}%")
  }

  scope :by_conference_participant_id, lambda { |conference_participant_id|
    return where nil if conference_participant_id.blank?

    where(conference_participant_id: conference_participant_id)
  }

  scope :by_conference_topic_id, lambda { |conference_topic_id|
    return where nil if conference_topic_id.blank?

    where(conference_topic_id: conference_topic_id)
  }

  scope :by_conference_id, lambda { |conference_id|
    return where nil if conference_id.blank?

    where(conference_id: conference_id)
  }

  def self.search(params = {})
    by_query(params[:query])
      .by_conference_participant_id(params[:conference_participant_id])
      .by_conference_topic_id(params[:conference_topic_id])
      .by_conference_id(params[:conference_id])
  end

  def full_name
    "#{front_title} #{name} #{back_title}"
  end

  def scholarship?
    data['scholarship']
  end

  def category_number
    data['category_number']
  end

  def abstract_file
    return latest_abstract_file.file if latest_abstract_file.present?

    abstract
  end

  def abstract_extenstion
    abstract_file.file.extension
  end

  def abstract_status
    return latest_abstract_file.status if latest_abstract_file.present?

    'submitted'
  end

  def abstract_submitted_date
    return latest_abstract_file.created_at if latest_abstract_file.present?

    created_at
  end

  def participant_number
    data['number']
  end

  def assign_reviewer?
    return false if abstract_file.blank? || abstract_status == 'final_review'

    true
  end

  def paper_status
    return paper_file.status if paper_file.present?

    'submitted'
  end

  def paper_reviewer?
    return false if paper_file.blank? || paper_status == 'final_review'

    true
  end

  def abstract_email?
    return true if abstract_file.blank?

    data['abstract_email']
  end

  def reguler_participant?
    abstract_file.blank?
  end
end
