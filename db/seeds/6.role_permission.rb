roles = [
  {
    role_code: 'superadmin',
    action: ['system.manage']
  }
]

roles.each do |r|
  role = Role.find_by(code: r[:role_code])
  next if role.nil?

  r[:action].each do |action|
    permission = Permission.find_by(action: action)
    next if permission.nil?

    role.permissions << permission
    role.save
  end
end
