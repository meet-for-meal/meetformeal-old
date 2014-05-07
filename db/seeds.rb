puts '' # Blank line
puts 'FILL WITH SEEDS'

puts '  Create ROLES'
YAML.load(ENV['ROLES']).split(' ').each do |role|
  Role.create name: role
  puts '    role: ' << role
end

puts '  Create default USER with admin role'
admin = User.create name: ENV['ADMIN_NAME'].dup,
                    email: ENV['ADMIN_EMAIL'].dup,
                    password: ENV['ADMIN_PASSWORD'].dup,
                    password_confirmation: ENV['ADMIN_PASSWORD'].dup
puts '    user: ' << admin.name
admin.add_role :admin
