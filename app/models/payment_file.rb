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
class PaymentFile < ParticipantFile
  has_one :participant_file_review, foreign_key: 'participant_file_id'

  def self.generate_invoice_number
    # get accepted payment file
    accepted_size = PaymentFile.where(status: 'accepted').size
    accepted_size += 1

    number = accepted_size.to_s
    if accepted_size <= 10
      number = accepted_size.to_s.rjust(2, '0')
    elsif accepted_size <= 100
      number = accepted_size.to_s.rjust(3, '0')
    elsif accepted_size <=1000
      number = accepted_size.to_s.rjust(4, '0')
    end
    "KONASKR/KHRHIAKMI/#{number}/2020"
  end

  def self.generate_participant_number
    # get accepted payment file
    accepted_size = PaymentFile.where(status: 'accepted').size
    accepted_size += 1

    number = accepted_size.to_s
    if accepted_size <= 10
      number = accepted_size.to_s.rjust(2, '0')
    elsif accepted_size <= 100
      number = accepted_size.to_s.rjust(3, '0')
    elsif accepted_size <=1000
      number = accepted_size.to_s.rjust(4, '0')
    end
    "KONASKR2020#{number}"
  end

  def sender_bank
    data['sender_bank']
  end

  def proceed?
    status == 'submitted'
  end

  def accepted?
    status == 'accepted'
  end

  def invoice_number
    data['invoice_number']
  end
end
