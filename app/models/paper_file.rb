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
class PaperFile < ParticipantFile

  def paper_title
    data['title']
  end

  def presenter
    data['presenter']
  end

  def need_review?
    status == 'need_review'
  end
end
