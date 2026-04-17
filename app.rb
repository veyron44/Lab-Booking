require_relative 'user'
require_relative 'resource'
require_relative 'booking'
require_relative 'errors'

@users = [
  User.new(id: 1, name: "Rahel", role: "student"),
  User.new(id: 2, name: "Haimi", role: "student"),
  User.new(id: 3, name: "fisshea", role: "assistant")
]

@resources = [
  Resource.new(id: 1, name: "Microscope", category: "Lab"),
  Resource.new(id: 102, name: "Projector", category: "Tech"),
  Resource.new(id: 103, name: "Laptop", category: "Tech")
]

@bookings = []

def show_menu
  puts "\n --- Lab Booking System ---"
  puts "1. View Resources "
  puts "2. Create Booking "
  puts "3. Cancel Booking"
  puts "4. Exit"
  print "\nChoose an option: "
end

loop do
  show_menu
  choice = gets.chomp

  case choice
  when "1"
    puts "\n Resource List "
    @resources.each do |r|
      if r.available?
        puts "#{r.id}: #{r.name} -> [Available]"
      else
        b = @bookings.find { |b| b.resource.id == r.id && b.status == "active" }
        puts "#{r.id}: #{r.name} -> [Booked by #{b.user.name}]"
      end
    end

  when "2"
    puts "\nWho is borrowing? (Enter User ID):"
    @users.each { |u| puts "#{u.id}: #{u.name}" }
    u_id = gets.chomp.to_i
    user = @users.find { |u| u.id == u_id }

    if user
      puts "Enter Resource ID to book:"
      res_id = gets.chomp.to_i
      resource = @resources.find { |r| r.id == res_id }

      if resource
        begin
          new_booking = Booking.new(user: user, resource: resource)
          @bookings << new_booking
          puts "Success! #{resource.name} is now with #{user.name}."
        rescue ResourceUnavailableError => e
          puts "Error: #{e.message}"
        end
      else
        puts "Resource not found."
      end
    else
      puts "User not found."
    end

  when "3"
    puts "\n--- Active Bookings ---"
    active = @bookings.select { |b| b.status == "active" }
    
    if active.empty?
      puts "No active bookings to cancel."
    else
      active.each_with_index { |b, i| puts "#{i+1}. #{b.resource.name} (Borrowed by: #{b.user.name})" }
      print "Choose the number to cancel: "
      idx = gets.chomp.to_i - 1

      if active[idx]
        active[idx].cancel
        puts "Cancelled, The item is now free."
      else
        puts "Invalid selection."
      end
    end

  when "4", "exit"
    
    break
  end
end