# == Schema Information
#
# Table name: permissions
#
#  id         :bigint           not null, primary key
#  name       :string
#  action     :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Permission < ApplicationRecord
  acts_as_paranoid

  has_many :role_abilities, dependent: :destroy
  
  def module_name
    action.split('.').first
  end

  def action_name
    action.split('.').last
  end
end
