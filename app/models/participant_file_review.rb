# frozen_string_literal: true

# == Schema Information
#
# Table name: participant_file_reviews
#
#  id                  :bigint           not null, primary key
#  participant_file_id :bigint
#  user_id             :bigint
#  status              :string
#  note                :string
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by          :integer
#  score               :integer
#
class ParticipantFileReview < ApplicationRecord
  acts_as_paranoid

  ABSTRACT_CRITERIA = [
    {
      min_score: 1,
      max_score: 5,
      min_desc: 'tidak penting',
      max_desc: 'sangat penting',
      key: 'Pentingnya isu atau rumusan masalah'
    },
    {
      min_score: 1,
      max_score: 5,
      min_desc: 'tidak jelas',
      max_desc: 'konten sangat jelas',
      key: 'Kejelasan konten abstrak'
    },
    {
      min_score: 1,
      max_score: 5,
      min_desc: 'metode/pendekatan tidak jelas',
      max_desc: 'metode/pendekatan sudah jelas',
      key: 'Metodologi atau pendekatan yang digunakan (pengumpulan data dan analisis)'
    },
    {
      min_score: 1,
      max_score: 5,
      min_desc: 'hasil tidak didukung data',
      max_desc: 'hasil sangat substantif',
      key: 'Temuan atau rekomendasi (data, temuan atau hasil berkaitan dengan tujuan)'
    },
    {
      min_score: 1,
      max_score: 5,
      min_desc: 'tidak relevan',
      max_desc: 'sangat relevan untuk pendengar dan tema konferensi',
      key: 'Relevansi dengan khalayak luas dan tema utama konferensi'
    }
  ].freeze

  ABSTRACT_REVIEWER = [
    { email: 'budi.utomo.ui@gmail.com', topic: [1, 11] },
    { email: 'aadisasmita@gmail.com', topic: [1] },
    { email: 'sawilopo@gmail.com', topic: [2] },
    { email: 'edesurya@gmail.com', topic: [2] },
    { email: 'bharyanto@ui.ac.id', topic: [3] },
    { email: 'zakianis@ui.ac.id', topic: [3] },
    { email: '71.bian@gmail.com', topic: [4] },
    { email: 'donihr_05@yahoo.com', topic: [4] },
    { email: 'fatmalestari9@gmail.com', topic: [4] },
    { email: 'astika.tria@gmail.com', topic: [5] },
    { email: 'asih.setiarini@gmail.com', topic: [5] },
    { email: 'baequniboerman@gmail.com', topic: [6] },
    { email: 'sandusiyotosandu@gmail.com', topic: [7] },
    { email: 'ritads@ui.ac.id', topic: [7] },
    { email: 'kotasehat@hotmail.com', topic: [8] },
    { email: 'januraga@unud.ac.id', topic: [9] },
    { email: 'erna_mutiara@yahoo.com', topic: [9] },
    { email: 'dsusanna2@yahoo.com', topic: [10] },
    { email: 'weka.gunawan@esaunggul.ac.id', topic: [10] },
    { email: 'dumilah.ayuningtyas@gmail.com', topic: [11] },
    { email: 'nazarudin.kemal51@gmail.com', topic: [12] },
    { email: 'hermawan.saputra@uhamka.ac.id', topic: [12] },
    { email: 'ajengtias82@gmail.com', topic: [13] },
    { email: 'd.linna.suswardany@ums.ac.id', topic: [13] },
    { email: 'hidayat@unfpa.org', topic: [14] },
    { email: 'mbudiharsana@gmail.com', topic: [14] },
    { email: 'rinaherartri@gmail.com', topic: [15] },
    { email: 'asnawi.abdullah@gmail.com', topic: [16] },
    { email: 'idale_262@yahoo.com', topic: [6, 15] },
    { email: 'immabatubara@gmail.com', topic: [8, 16] }
  ].freeze

  belongs_to :participant_file
  belongs_to :user, -> { with_deleted }
  delegate   :participant, to: :participant_file, allow_nil: true
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by', optional: true

  scope :by_query, lambda { |query|
    return where nil if query.blank?

    query.downcase!
    query.strip!

    joins(participant_file: :participant)
      .where('lower(participants.name) LIKE :query OR lower(participants.topic) LIKE :query', query: "%#{query}%")
  }

  scope :by_status, lambda { |status|
    return where nil if status.blank?

    # status.downcase!
    # status.strip!

    where('lower(participant_file_reviews.status) = ?', status)
  }

  scope :by_user, lambda { |user_id|
    return where nil if user_id.blank?

    where(user_id: user_id)
  }

  def self.search(params)
    by_query(params[:query])
      .by_status(params[:status])
      .by_user(params[:user_id])
  end

  def proceed?
    status == 'submitted'
  end
end
