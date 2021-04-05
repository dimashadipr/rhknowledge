# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  type       :string
#  code       :string
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Role < ApplicationRecord
  acts_as_paranoid

  has_many :role_abilities, dependent: :destroy
  has_many :permissions, through: :role_abilities
  has_many :users

  accepts_nested_attributes_for :role_abilities, allow_destroy: true, reject_if: proc { |attr| attr['permission_id'].blank? }

  scope :by_query, lambda { |query|
    return where(nil) if query.blank?

    where('roles.name ILIKE :query OR roles.type ILIKE :query OR roles.code ILIKE :query',
          query: "%#{query}%")
  }

  def self.search(params = {})
    params = {} if params.blank?

    by_query(params[:query])
  end

  def self.options
    where.not(code: 'superadmin').map { |r| [r.name, r.id] }
  end
end
