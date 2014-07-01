@random_users = [
  {name: 'Jean Martin', gender: 'male'},
  {name: 'Pierre Bernard', gender: 'male'},
  {name: 'Paul Dubois', gender: 'male'},
  {name: 'Jacques Richard', gender: 'male'},
  {name: 'Robert Petit', gender: 'male'},
  {name: 'Jeanne Durand', gender: 'female'},
  {name: 'Marie Moreau', gender: 'female'},
  {name: 'Catherine Simon', gender: 'female'},
  {name: 'Nicole Laurent', gender: 'female'},
  {name: 'Françoise Lefebvre', gender: 'female'}
]

def random_hobbies
  hobbies = %w{ soccer handball drinking movie tennis guitare drum coding dancing rugby dj }
  "#{hobbies.sample}, #{hobbies.sample}, #{hobbies.sample}, #{hobbies.sample}"
end

def random_foods
  foods = %w{ burgers chinois français indien japonais coréen pizza sandwitch sushis tapas thaïlandais turc grec végétarien }
  "#{foods.sample}, #{foods.sample}, #{foods.sample}, #{foods.sample}"
end

def create_test_user(i)
  random_i = (0...@random_users.size).to_a.sample
  random_user = @random_users[random_i]
  @random_users.delete(random_i)
  test_user = User.create name: random_user[:name],
                          email: "#{i}-#{ENV['TEST_EMAIL'].dup}",
                          gender: random_user[:gender],
                          password: ENV['TEST_PASSWORD'].dup,
                          password_confirmation: ENV['TEST_PASSWORD'].dup
  puts '    Create USER: ' << test_user.name
  test_user_foods = random_foods
  puts "      Add foods [#{test_user_foods}] to user #{test_user.name}"
  test_user.food_list = test_user_foods
  test_user.save
  test_user_hobbies = random_hobbies
  puts "      Add hobbies [#{test_user_hobbies}] to user #{test_user.name}"
  test_user.hobby_list = test_user_hobbies
  test_user.save
  test_user
end

def generate_announcement_hash(user, i)
  now = DateTime.now
  duration = 2.hours
  from = now + (0..480).to_a.sample.minutes
  {
    title: "Annonce Test ##{i}",
    description: "Salut, je suis #{user.name} et voici l'annonce ##{i}",
    time_from: from,
    time_to: from + duration,
    lat: rand(48.8...48.9).round(5), # Near center of Paris
    lng: rand(2.3...2.4).round(5),
    owner: user
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
admin = User.create name: ENV['ADMIN_NAME'].dup,
                    email: ENV['ADMIN_EMAIL'].dup,
                    gender: ENV['ADMIN_GENDER'].dup,
                    password: ENV['ADMIN_PASSWORD'].dup,
                    password_confirmation: ENV['ADMIN_PASSWORD'].dup

puts "  Create default admin USER '#{admin.name}' with admin role"
puts "  Add admin role to user #{admin.name}"
admin.add_role :admin
admin_foods = random_foods
puts "  Add foods [#{admin_foods}] to user #{admin.name}"
admin.food_list = admin_foods
admin.save
admin_hobbies = random_hobbies
puts "  Add hobbies [#{admin_hobbies}] to user #{admin.name}"
admin.hobby_list = admin_hobbies
admin.save


# Announcements
puts '  Create sample ANNOUNCEMENTS'
(1..5).each do |i|
  announcement = Announcement.create generate_announcement_hash(create_test_user(i), i)
  puts "    #{announcement.title}: [#{announcement.lat}, #{announcement.lng}] at #{announcement.time_from.hour}:#{announcement.time_from.minute}"
end
hash = generate_announcement_hash(admin, 'admin')
announcement = Announcement.create hash
puts "    #{announcement.title}: [#{hash[:lat]}, #{hash[:lng]}]"
