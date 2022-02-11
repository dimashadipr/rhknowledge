# == Schema Information
#
# Table name: translations
#
#  id            :bigint           not null, primary key
#  lang          :string
#  resource_type :string
#  resource_id   :integer
#  column        :string
#  content       :text
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Translation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
