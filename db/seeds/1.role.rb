# frozen_string_literal: true

puts 'Role Seeder'
roles = [
  {
    type: 'RoleAdmin',
    code: 'superadmin',
    name: 'Superadmin'
  },
  {
    type: 'RoleAdmin',
    code: 'admin',
    name: 'Admin'
  },
  {
    type: 'RoleAdmin',
    code: 'conference_admin',
    name: 'Conference Admin'
  },
  {
    type: 'RoleAdmin',
    code: 'track_director',
    name: 'Track Director'
  },
  {
    type: 'RoleAdmin',
    code: 'reviewer',
    name: 'Reviewer'
  },
  {
    type: 'RoleAdmin',
    code: 'bendahara',
    name: 'Bendahara'
  },
  {
    type: 'RoleAdmin',
    code: 'registrasi',
    name: 'Registrasi'
  }
]

roles.each do |role|
  role_db = Role.find_or_initialize_by(code: role[:code])

  role_db.type = role[:type]
  role_db.name = role[:name]

  role_db.save

  puts "Saved Roles #{role_db.id} - #{role_db.name}"
end
