
require_relative '../config/environment'
require_relative './customer_cli.rb'
require_relative './restaurant_cli.rb'
require_relative './animation.rb'

# add more opportunities to exit program

# --------------------------
# helper methods

def get_valid_input(v_array)
  #helper function that takes in an array of accepted inputs. the method loops until the user inputs one of the matching values (not case sensitive)
  input = gets.chomp.downcase
  until v_array.include?(input)
    puts 'Not a valid input, please try again.'
    input = gets.chomp.downcase
  end
  input
end

# ------------------------------------------------
# run methods

def greeting
  #hi

  puts "\n"
  puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
  puts "\n"
  puts '                  Welcome to Reward Bot!'
  puts "\n"
  puts "                     With Reward Bot"
  puts ' • Customers can check their ratings and earned rewards.'
  puts ' • Restaurants can create rewards programs and rate customers.'
  puts "\n"
  puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
  puts "\n"
end

def customer_or_restaurant
  #app functionality is split between customers and restaurants
  puts 'Log on as a [c]ustomer or [r]estaurant: '
  input = get_valid_input(%w[c r customer restaurant])
  if input == 'c' || input == 'customer'
    'customer'
  else
    'restaurant'
  end
end

# -----------------------------------------------
# run function

def run
  #main run function

  animation #plays an animation
  greeting

  user_type = customer_or_restaurant

  if user_type == 'customer'
    customer_processing
  elsif user_type == 'restaurant'
    restaurant_processing
  end

  puts "\n"
  puts 'Thank you for using Reward Bot!'
  #bye
end

run

#
