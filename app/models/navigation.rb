# frozen_string_literal: true

# == Schema Information
#
# Table name: navigations
#
#  id            :bigint           not null, primary key
#  navigation_id :integer
#  code          :string
#  position      :integer
#  title         :string
#  page_id       :bigint
#  level         :integer
#  editable      :boolean          default("true")
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tooltip       :string
#
class Navigation < ApplicationRecord
  acts_as_paranoid

  TRANSLATION_FIELDS = %i[title].freeze
  translate TRANSLATION_FIELDS

  belongs_to :parent, class_name: 'Navigation', optional: true, foreign_key: :navigation_id
  belongs_to :page, optional: true

  has_many :childrens, -> { order(position: :asc) }, class_name: 'Navigation', dependent: :destroy

  def self.parent_nav
    where(navigation_id: nil).order(position: :asc)
  end

  def landing?
    childrens.blank?
  end

  def dropdown?
    !childrens.blank?
  end

  def to_node
    {
      id: id,
      name: "#{title} - #{id}",
      children: childrens.map(&:to_node)
    }
  end

  def all_children_recursion
    children.flat_map do |child_cat|
      child_cat.all_children_recursion << child_cat
    end
  end

  def titles
    array = [{ level: level, title: title }]
    array += parent.titles if parent.present?
    array.sort_by{ |e| e[:level] }
  end
end
