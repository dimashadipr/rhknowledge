# frozen_string_literal: true

permissions = [
  { name: 'Manage All Resources', action: 'system.manage' },
  # dashboard
  { name: 'Access Dashboard Data', action: 'dashboard.read' },

  # homepages
  { name: 'Homepage Edit Page', action: 'homepage.read' },
  { name: 'Update Homepage', action: 'homepage.update' },

  # networks
  { name: 'Newtork List', action: 'network.read' },
  { name: 'Newtork Create', action: 'network.create' },
  { name: 'Update Newtork', action: 'network.update' },
  { name: 'Delete Newtork', action: 'network.delete' },

  # Resource Page
  { name: 'Resources List', action: 'resource.read' },
  { name: 'Resources Create', action: 'resource.create' },
  { name: 'Update Resources', action: 'resource.update' },
  { name: 'Delete Resources', action: 'resource.delete' },

  # Navigations
  { name: 'Navigation List', action: 'navigation.read' },
  { name: 'Navigation Create', action: 'navigation.create' },
  { name: 'Update Navigation', action: 'navigation.update' },
  { name: 'Delete Navigation', action: 'navigation.delete' },

  # Conferences
  { name: 'Conference List', action: 'conference.read' },
  { name: 'Conference Create', action: 'conference.create' },
  { name: 'Update Conference', action: 'conference.update' },
  { name: 'Delete Conference', action: 'conference.delete' },
  { name: 'Report Conference', action: 'conference_report.read' },

  # Events
  { name: 'Event List', action: 'event.read' },
  { name: 'Event Create', action: 'event.create' },
  { name: 'Update Event', action: 'event.update' },
  { name: 'Delete Event', action: 'event.delete' },

  # Subcriptions
  { name: 'Subcription List', action: 'subscription.read' },
  { name: 'Subcription Create', action: 'subscription.create' },
  { name: 'Update Subcription', action: 'subscription.update' },
  { name: 'Delete Subcription', action: 'subscription.delete' },

  # Visitors
  { name: 'Visitor List', action: 'visitor.read' },

  # Inquiries
  { name: 'Inquiry List', action: 'inquiry.read' },

  # Roles
  { name: 'Role List', action: 'role.read' },
  { name: 'Role Create', action: 'role.create' },
  { name: 'Update Role', action: 'role.update' },
  { name: 'Delete Role', action: 'role.delete' },

  # User
  { name: 'User List', action: 'user.read' },
  { name: 'User Create', action: 'user.create' },
  { name: 'Update User', action: 'user.update' },
  { name: 'Delete User', action: 'user.delete' },

  # Mailer
  { name: 'Email List', action: 'mailer.read' },
  { name: 'Email Create', action: 'mailer.create' },

  # participant
  { name: 'Participant List', action: 'participant.read' },
  { name: 'Assign Reviewer Abstract', action: 'participant.assign_reviewer' },
  { name: 'Final Review Abstract', action: 'participant.final_review' },
  { name: 'Upload Abstract', action: 'participant.upload_abstract' },
  { name: 'Delete Participant', action: 'participant.delete' },

  # review
  { name: 'Review Abstract List', action: 'review.read' },
  { name: 'Update Review Abstract', action: 'review.update' },

  # payments
  { name: 'Review Payment List', action: 'payment.read' },
  { name: 'Update Payment', action: 'payment.update' }
]

active_ids = []

permissions.each do |p|
  puts "find #{p[:action]} = #{p[:name]}"
  permission = Permission.find_or_initialize_by(action: p[:action])
  permission.name = p[:name]
  permission.save

  active_ids << permission.id
end

# destroy obsolete
permissions = Permission.where.not(id: active_ids)
permissions.each(&:destroy)
