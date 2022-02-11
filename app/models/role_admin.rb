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
class RoleAdmin < Role
end
