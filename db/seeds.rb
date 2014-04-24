# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  # puts role.inspect
  Role.where(name: role).first_or_create
  # find_or_create_by depricated in rails 4
  # Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.create :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
user2 = User.create :name => 'Silver User', :email => 'peter.alderson@gmail.com', :password => 'changeme', :password_confirmation => 'changeme'
user2.add_role :silver
user3 = User.create :name => 'Gold User', :email => 'user3@example.com', :password => 'changeme', :password_confirmation => 'changeme'
user3.add_role :gold
user4 = User.create :name => 'Platinum User', :email => 'user4@example.com', :password => 'changeme', :password_confirmation => 'changeme'
user4.add_role :platinum
puts "users: #{user2.name}, #{user3.name}, #{user4.name}"
