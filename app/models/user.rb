# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  type                   :string
#  role_id                :bigint
#  name                   :string
#  phone                  :string
#  deleted_at             :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  data                   :jsonb
#
class User < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: { case_sensitive: false }

  belongs_to :role, optional: true
  has_many :permissions, through: :role

  scope :by_query, lambda { |query|
    return where nil if query.blank?

    query.downcase!
    query.strip!

    where('lower(users.name) LIKE :query OR lower(users.email) LIKE :query', query: "%#{query}%")
  }

  scope :by_role, lambda { |role_id|
    return where nil if role_id.blank?

    where(role_id: role_id)
  }

  def self.search(params = {})
    params = {} if params.blank?

    by_query(params[:query])
      .by_role(params[:role])
  end

  def first_time_login?
    return true if data.blank?

    data['first_time']
  end

  def superadmin?
    role.code == 'superadmin'
  end

  def reviewer?
    role.code == 'reviewer'
  end
end
