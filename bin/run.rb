
require_relative '../config/environment'
require_relative './customer_cli.rb'
require_relative './restaurant_cli.rb'
require_relative './animation.rb'

# add more opportunities to exit program

# --------------------------
# helper methods

def get_valid_input(v_array)
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
  puts 'Log on as a [c]ustomer or [r]estaurant: '
  input = get_valid_input(%w[c r customer restaurant])
  if input == 'c' || input == 'customer'
    'customer'
  else
    'restaurant'
  end
end

# def customer_processing
#   customer = get_customer
#
#   if customer == 'exit'
#     puts 'Goodbye'
#     return
#   elsif customer == 'new'
#     puts 'New account created. Go eat at participating restaurants to start earning rewards!'
#     return
#   end
#
#   puts "Welcome #{customer.username}."
#
#   loop do
#     puts 'Would you like to check your [s]cores, view your [r]ewards, or e[x]it?'
#     input = get_valid_input(%w[s score scores r reward rewards x exit])
#
#     if %w[s score scores].include?(input)
#       view_customer_scores(customer)
#     elsif %w[r reward rewards].include?(input)
#       view_customer_rewards(customer)
#     else
#       break
#     end
#   end
# end

# def restaurant_processing
#   restaurant = get_restaurant
#
#   if restaurant == 'exit'
#     puts 'Goodbye'
#     return
#   end
#
#   puts 'Would you like to [r]eview a customer, or [e]dit your reward program?' # add view customer stats
#   input = get_valid_input(%w[r review e edit]) # best/worst customer, how many visits a customer has at ur restaurant
#   if input == 'r' || input == 'review' # view reward program, amount of customers per reward, see average scores for your restaurant
#     review_customer(restaurant)
#   else
#     modify_reward_program(restaurant)
#   end
# end

# # --------------------------------------------------
# # customer processing helper methods
#
# def get_customer
#   print 'Please enter your username: '
#   name = gets.chomp
#   customer = Customer.all.find_by(username: name)
#
#   if customer.nil?
#     puts "#{name} doesn't exist in our database."
#     puts 'Would you like to [c]reate a new customer account, [t]ry again, or e[x]it?'
#     input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
#     if input == 'c' || input == 'create'
#       print 'Enter a password: ' # try to hide password
#       pass = gets.chomp
#       puts "Creating a new customer, #{name}..."
#       customer = Customer.create(username: name, password: pass)
#       return 'new'
#     elsif input == 'x' || input == 'exit'
#       return 'exit'
#     end
#   else
#     print 'please enter your password: '
#     pass = gets.chomp
#     if pass == customer.password
#       return customer
#     else
#       puts 'Incorrect password, logging off...'
#       return exit
#     end
#   end
# end
#
# def list_scores
#   puts "Type the number of the score you'd like to see, or [i]nfo for more information on these categories."
#   puts '1. Etiquette Score'
#   puts '2. Punctuality Score'
#   puts '3. Tipping Score'
#   puts '4. Overall Score'
# end
#
# def about_scores
#   puts 'Your etiquette score reflects your interactions with restaurant staff.'
#   puts 'Your punctuality score reflects how timely you are with your reservations.'
#   puts 'Your tipping score reflects how well you tip.'
#   puts 'Your overall score is an average of your etiquette, punctuality, and tipping scores.'
#   puts "Type 'list' to see your scores or 'exit' to log out."
# end
#
# def get_score(customer, score)
#   if !customer.get_average_overall_rating.nan?
#     if score == '1'
#       puts "Your etiquette score: #{customer.get_average_etiquette_score}."
#     elsif score == '2'
#       puts "Your punctuality score: #{customer.get_average_punctuality_score}."
#     elsif score == '3'
#       puts "Your tipping score: #{customer.get_average_tipping_score}."
#     elsif score == '4'
#       puts "Your overall score: #{customer.get_average_overall_rating}."
#     end
#   else
#     puts "You don't have any scores yet. Check again after your next restaurant visit."
#   end
# end
#
# def view_customer_scores(customer)
#   list_scores
#   input = get_valid_input(%w[i info 1 2 3 4])
#
#   if input == 'i' || input == 'info'
#     about_scores
#     puts 'Choose a number 1-4.'
#     input = get_valid_input(%w[1 2 3 4])
#   end
#
#   get_score(customer, input)
# end
#
# def view_customer_rewards(customer)
#   puts 'You qualify for the following rewards: ' # use full method functionality with restaurant and type inputs
#   customer.find_reward_qualifications.each { |i| puts "#{i.restaurant.name}: #{i.label} - Desc: #{i.reward_description}" }
# end

# -----------------------------------------------
# restaurant processing helper methods

# def get_restaurant
#   print 'Please enter your restaurant name: '
#   name = gets.chomp
#   restaurant = Restaurant.all.find_by(name: name)
#
#   if restaurant.nil?
#     puts "#{name} doesn't exist in our database."
#     puts 'Would you like to [c]reate a new restaurant account, [t]ry again, or e[x]it?'
#     input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
#     if input == 'c' || input == 'create'
#       print 'Enter a password for your restaurant: ' # try to hide password
#       pass = gets.chomp
#       puts "Creating a new restaurant, #{name}..."
#       restaurant = Restaurant.create(name: name, password: pass)
#     elsif input == 'x' || input == 'exit'
#       return 'exit'
#     end
#   else
#     print 'please enter your password: '
#     pass = gets.chomp
#     if pass == restaurant.password
#       return restaurant
#     else
#       puts 'Incorrect password, logging off...' # instead of logging off, allow for try again in case typo
#       return exit
#     end
#   end
# end
#
# # def review_customer(restaurant)
# #   puts "What is your customer's username?"
# #   customer = get_reviewee
# #   return if customer == 'x' || customer == 'exit'
# #
# #   range = (1..5).map(&:to_s)
# #   puts "How would you rate #{customer.username}'s etiquette? (1-5)"
# #   e = get_valid_input(range)
# #   puts "How would you rate #{customer.username}'s punctuality? (1-5)"
# #   p = get_valid_input(range)
# #   puts "How would you rate #{customer.username}'s tipping? (1-5)"
# #   t = get_valid_input(range)
# #   restaurant.write_review(customer, e, p, t)
# #   puts "Your review for #{customer.username} was submitted." # find way to send you back to main menu
# #
# #   puts 'Would you like to [r]eview another customer, or e[x]it?'
# #   input = get_valid_input(%w[r review x exit])
# #   if input == 'x' || input == 'exit'
# #     return # find way to send you back to main menu
# #   else
# #     review_customer(restaurant)
# #   end
# # end
#
# def time_method(customer)
#   puts "Was #{customer.username} [e]arly, [l]ate, or [o]n time?"
#   time = get_valid_input(%w[e l o]) #need error handling
#   if time == 'e'
#     puts "How early was #{customer.username}?"
#     time = -gets.chomp
#   elsif time == 'o'
#     time = 0
#   elsif time == 'l'
#     puts "How late was #{customer.username}?"
#     time = gets.chomp
#   else
#     puts 'Incorrect input. Try again or e[x]it.'
#     time_method
# end
#   time
# end
#
# def review_customer(restaurant)
#   puts "What is your customer's username?"
#   customer = get_reviewee
#   return if customer == 'x' || customer == 'exit'
#
#   range = (1..5).map(&:to_s)
#   puts "How would you rate #{customer.username}'s etiquette? (1-5)"
#   e = get_valid_input(range)
#   t = time_method(customer)
#   puts "How much was #{customer.username}’s bill?"
#   bill = gets.chomp
#   puts "How much did #{customer.username} pay?"
#   paid = gets.chomp
#   restaurant.write_review(customer, e, t, bill, paid)
#   puts "Your review for #{customer.username} was submitted." # find way to send you back to main menu
#
#   puts 'Would you like to [r]eview another customer, or e[x]it?'
#   input = get_valid_input(%w[r review x exit])
#   if input == 'x' || input == 'exit'
#     return # find way to send you back to main menu
#   else
#     review_customer(restaurant)
#   end
# end
#
# def get_reviewee
#   name = gets.chomp
#   customer = Customer.all.find_by(username: name)
#
#   if customer.nil?
#     puts "Sorry, #{name} doesn't exist in our database."
#     return 'exit'
#   else
#     return customer
#   end
# end
#
# def modify_reward_program(restaurant) # add "review rewards" method for restaurants
#   puts "Modifying the reward program for #{restaurant.name}"
#   puts 'Do you want to [e]dit an existing reward or [a]dd a new one?'
#   input = get_valid_input(%w[e edit a add])
#
#   if input == 'e' || input == 'edit'
#     choose_reward_to_edit(restaurant)
#   else
#     add_reward(restaurant) # find way to send you back to main menu
#   end
# end
#
# def choose_reward_to_edit(restaurant)
#   puts "Editing rewards for #{restaurant.name}..."
#   puts 'Please be considerate of customers and change rewards infrequently.' # You can't unchange this warning
#   puts 'current rewards for this program: '
#   all_rewards = restaurant.get_potential_rewards
#   (1..all_rewards.size).each do |i|
#     reward = all_rewards[i - 1]
#     puts "#{i}: #{reward.label} - Desc: #{reward.reward_description} for customers with a #{reward.requirement} #{reward.reward_type} rating."
#   end
#   puts 'Enter the number of the reward you would like to edit'
#   input = get_valid_input((1..all_rewards.size).map(&:to_s))
#   active_reward = all_rewards[input.to_i - 1]
#
#   edit_reward(active_reward, restaurant)
# end
#
# def edit_reward(active_reward, restaurant)
#   puts "Current reward data for the #{active_reward.label} reward: "
#   puts "label: #{active_reward.label}, type: #{active_reward.reward_type}, requirement: #{active_reward.requirement}, desc: #{active_reward.reward_description}."
#   puts 'Enter the new values for this reward: '
#   puts 'Choose the name for your new reward (example: Platinum Tier, Early Bird)'
#   label = gets.chomp
#   puts 'Choose the customer score your reward should examine (one of Overall/Etiquette/Punctuality/Tipping)'
#   type = get_valid_input(%w[overall etiquette punctuality tipping]).capitalize
#   puts 'Choose the required score for earning this reward (1.0 - 5.0)'
#   req = gets.chomp.to_f
#   until (1.0..5.0).cover?(req)
#     puts 'Not a valid input, please try again.'
#     req = gets.chomp.to_f
#   end
#   puts 'Enter the reward a customer will receive for meeting these requirements (example: 20% discount, Booking Priority)'
#   desc = gets.chomp
#
#   Reward.all.delete(active_reward.id)
#   restaurant.create_reward(label, req, desc, type)
#   puts 'Reward updated!'
# end
#
# def add_reward(restaurant)
#   puts 'Adding new reward...'
#   puts 'Choose the name for your new reward (example: Platinum Tier, Early Bird)'
#   label = gets.chomp
#   puts 'Choose the customer score your reward should examine (one of Overall/Etiquette/Punctuality/Tipping)'
#   type = get_valid_input(%w[overall etiquette punctuality tipping]).capitalize
#   puts 'Choose the required score for earning this reward (1.0 - 5.0)'
#   req = gets.chomp.to_f
#   until (1.0..5.0).cover?(req)
#     puts 'Not a valid input, please try again.'
#     req = gets.chomp.to_f
#   end
#   puts 'Enter the reward a customer will receive for meeting these requirements (example: 20% discount, Booking Priority)'
#   desc = gets.chomp
#   restaurant.create_reward(label, req, desc, type)
#   puts 'New reward added!'
# end

# -----------------------------------------------
# run function

def run
  animation
  greeting

  user_type = customer_or_restaurant

  if user_type == 'customer'
    customer_processing
  elsif user_type == 'restaurant'
    restaurant_processing
  end

  puts "\n"
  puts 'Thank you for using Reward Bot!'
end

run

#
