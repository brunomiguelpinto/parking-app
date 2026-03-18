admin = User.find_or_create_by!(email: "admin@parking.local") do |u|
  u.name = "Admin"
  u.password = "admin123"
  u.password_confirmation = "admin123"
  u.role = :admin
end

puts "Admin criado: #{admin.email} / admin123"

%w[A1 A2 A3 B1 B2 B3].each do |name|
  ParkingSpot.find_or_create_by!(name: name)
end

puts "#{ParkingSpot.count} lugares criados."
