def generate_announcement_hash(user, i)
  now = DateTime.now
  {
    title: "Test announcement ##{i}",
    description: "Hello, I'm #{user.name} and this is the announcement ##{i}",
    time_from: now + 2.hours,
    time_to: now + 4.hours,
    lat: rand(48.8...48.9).round(5), # Near center of Paris
    lng: rand(2.3...2.4).round(5),
    user: user
  }
end


puts '' # Blank line
puts 'FILL WITH SEEDS'


# Roles
puts '  Create ROLES'
YAML.load(ENV['ROLES']).split(' ').each do |role|
  Role.create name: role
  puts '    role: ' << role
end


# Users
puts '  Create default admin USER with admin role'
admin = User.create name: ENV['ADMIN_NAME'].dup,
                    email: ENV['ADMIN_EMAIL'].dup,
                    gender: ENV['ADMIN_GENDER'].dup,
                    password: ENV['ADMIN_PASSWORD'].dup,
                    password_confirmation: ENV['ADMIN_PASSWORD'].dup

puts '    user: ' << admin.name
puts "  Add admin role to user #{admin.name}"
admin.add_role :admin
admin_foods = 'italian, japanese, indian, pakistani'
puts "  Add foods [#{admin_foods}] to user #{admin.name}"
admin.food_list = admin_foods
admin.save
admin_hobbies = 'soccer, coding, handball'
puts "  Add hobbies [#{admin_hobbies}] to user #{admin.name}"
admin.hobby_list = admin_hobbies
admin.save

puts '  Create default test USER'
test_user = User.create name: ENV['TEST_NAME'].dup,
                        email: ENV['TEST_EMAIL'].dup,
                        gender: ENV['TEST_GENDER'].dup,
                        password: ENV['TEST_PASSWORD'].dup,
                        password_confirmation: ENV['TEST_PASSWORD'].dup

puts '    user: ' << test_user.name
test_user_foods = 'spanish, british, indian, pakistani'
puts "  Add foods [#{test_user_foods}] to user #{test_user.name}"
test_user.food_list = test_user_foods
test_user.save
test_user_hobbies = 'guitare, drum, coding'
puts "  Add hobbies [#{test_user_hobbies}] to user #{test_user.name}"
test_user.hobby_list = test_user_hobbies
test_user.save


# Announcements
puts '  Create sample ANNOUNCEMENTS'
(1..5).each do |i|
  announcement = Announcement.create generate_announcement_hash(test_user, i)
  puts "    #{announcement.title}:     [#{announcement.lat}, #{announcement.lng}]"
end
hash = generate_announcement_hash(admin, 'admin')
announcement = Announcement.create hash
puts "    #{announcement.title}: [#{hash[:lat]}, #{hash[:lng]}]"
