
# ----------------------------------------------------

def restaurant_processing
  restaurant = get_restaurant

  if restaurant == 'exit'
    puts 'Goodbye'
    return
  end

  actions = ['[r]eview a customer', '[e]dit/change your rewards program', '[v]iew information', 'e[x]it the app']
  while true
    puts "\n"
    puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
    puts "\n"
    puts "Choose an action:"
    puts "\n"
    for i in (1..4)
      puts "#{i}: #{actions[i - 1]}"
    end
    input = get_valid_input(["1", "2", "3", "4", "r", "review", "e", "edit", "v", "view", "x", "exit"])
    if ["1", "r", "review"].include?(input)
      review_customer(restaurant)
    elsif ["2", "e", "edit"].include?(input)
      modify_reward_program(restaurant)
    elsif ["3", "v", "view"].include?(input)
      view_information(restaurant) #not created yet
    else
      return
    end
  end
end

# --------------------
  #log on/get user function

def restaurant_exists?(name)
  restaurant = Restaurant.all.find_by(name: name)
  if restaurant.nil?
    return false
  else
    return true
  end
end

def create_restaurant(name)
  if !restaurant_exists?(name)
    print 'Create a password: ' # try to hide password
    pass = STDIN.noecho(&:gets).chomp
    puts "Creating a new restaurant, #{name}..."
    restaurant = Restaurant.create(name: name, password: pass)
  else
    puts "This restaurant already exists. Try another restaurant name."
    name = gets.chomp
    create_user(name)
  end
end


def check_restaurant(name)
  puts "#{name} doesn't exist in our database."
  puts "\n"
  puts 'Would you like to [c]reate a new restaurant account, [t]ry again, or e[x]it?'
  input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
  if input == 'c' || input == 'create'
    puts "\n"
    puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
    puts "\n"
    print 'Create a restaurant name:'
    rest = gets.chomp
    create_restaurant(rest)
  elsif input == 't' || input == 'try again'
    get_restaurant
  elsif input == 'x' || input == 'exit'
    return 'exit'
  end
end

def get_restaurant
  puts "\n"
  print 'Please enter your restaurant name: '
  name = gets.chomp
  restaurant = Restaurant.all.find_by(name: name)


  #try again option is bugged, need to fix
  if restaurant.nil?
    check_restaurant(name)
  else
    count = 0
    get_password(count, restaurant)
  end
end

def get_password(count, restaurant)
if count == 0
  puts 'Please enter your password: '
elsif count > 0
  puts 'Incorrect password, Try again. '
end
pass = STDIN.noecho(&:gets).chomp
puts "\n"
count += 1
  if pass == restaurant.password
    return restaurant
  elsif count <= 3
    get_password(count, restaurant)
  elsif count > 3
    puts "\n"
    puts 'Incorrect password, logging off...' # instead of logging off, allow for try again in case typo
    return exit
  end
end
#-------------------
  #customer review methods

def review_customer(restaurant)

  puts "What is your customer's username?"
  customer = get_reviewee
  return if customer == 'exit'

  range = (1..5).map(&:to_s)
  puts "How would you rate #{customer.username}'s etiquette? (1-5)"
  e = get_valid_input(range)
  t = time_method(customer)
  puts "How much was #{customer.username}’s bill?"
  bill = gets.chomp
  puts "How much did #{customer.username} pay?"
  paid = gets.chomp
  restaurant.write_review(customer, e, t, bill, paid)
  puts "Your review for #{customer.username} was submitted."

end

def get_reviewee
  name = gets.chomp
  customer = Customer.all.find_by(username: name)

  if customer.nil?
    puts "Sorry, #{name} doesn't exist in our database."
    puts "Customers must create an account on Reward Bot in order to participate in your rewards program."
    puts "\n"
    return 'exit'
  else
    return customer
  end
end

def time_method(customer)
  puts "Was #{customer.username} [e]arly, [l]ate, or [o]n time?"
  time = get_valid_input(%w[e l o]) #need error handling
  if time == 'e'
    puts "How early was #{customer.username}? (in minutes)"
    time = -gets.chomp
  elsif time == 'o'
    time = 0
  elsif time == 'l'
    puts "How late was #{customer.username}? (in minutes)"
    time = gets.chomp
  else
    puts 'Incorrect input. Try again or e[x]it.'
    time_method
end
  time
end

# -----------------------
  #reward program methods

def modify_reward_program(restaurant) # add "review rewards" method for restaurants
  puts "Modifying the reward program for #{restaurant.name}"
  puts 'Do you want to [e]dit an existing reward or [a]dd a new one?'
  input = get_valid_input(%w[e edit a add])

  if input == 'e' || input == 'edit'
    choose_reward_to_edit(restaurant)
  else
    add_reward(restaurant)
  end
end

def choose_reward_to_edit(restaurant)
  puts "Editing rewards for #{restaurant.name}..."
  puts 'Please be considerate of customers and change rewards infrequently.' # You can't unchange this warning
  puts 'current rewards for this program: '
  all_rewards = restaurant.get_potential_rewards
  (1..all_rewards.size).each do |i|
    reward = all_rewards[i - 1]
    puts "#{i}: #{reward.label} - Desc: #{reward.reward_description} for customers with a #{reward.requirement} #{reward.reward_type} rating."
  end
  puts 'Enter the number of the reward you would like to edit'
  input = get_valid_input((1..all_rewards.size).map(&:to_s))
  active_reward = all_rewards[input.to_i - 1]

  edit_reward(active_reward, restaurant)
end

def edit_reward(active_reward, restaurant)
  puts "\n"
  puts "Current reward data for the #{active_reward.label} reward: "
  puts "label: #{active_reward.label}, type: #{active_reward.reward_type}, requirement: #{active_reward.requirement}, desc: #{active_reward.reward_description}."
  puts 'Enter the new values for this reward: '
  puts 'Choose the name for your new reward (example: Platinum Tier, Early Bird)'
  label = gets.chomp
  puts 'Choose the customer score your reward should examine (one of Overall/Etiquette/Punctuality/Tipping)'
  type = get_valid_input(%w[overall etiquette punctuality tipping]).capitalize
  puts 'Choose the required score for earning this reward (1.0 - 5.0)'
  req = gets.chomp.to_f
  until (1.0..5.0).cover?(req)
    puts 'Not a valid input, please try again.'
    req = gets.chomp.to_f
  end
  puts 'Enter the reward a customer will receive for meeting these requirements (example: 20% discount, Booking Priority)'
  desc = gets.chomp

  Reward.all.delete(active_reward.id)
  restaurant.create_reward(label, req, desc, type)
  puts 'Reward updated!'
end

def add_reward(restaurant)
  puts 'Adding new reward...'
  puts 'Choose the name for your new reward (example: Platinum Tier, Early Bird)'
  label = gets.chomp
  puts 'Choose the customer score your reward should examine (one of Overall/Etiquette/Punctuality/Tipping)'
  type = get_valid_input(%w[overall etiquette punctuality tipping]).capitalize
  puts 'Choose the required score for earning this reward (1.0 - 5.0)'
  req = gets.chomp.to_f
  until (1.0..5.0).cover?(req)
    puts 'Not a valid input, please try again.'
    req = gets.chomp.to_f
  end
  puts 'Enter the reward a customer will receive for meeting these requirements (example: 20% discount, Booking Priority)'
  desc = gets.chomp
  restaurant.create_reward(label, req, desc, type)
  puts 'New reward added!'
end

# --------------------
  #view info methods

def view_information(restaurant)
  puts "\n"
  puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
  puts "\n"
  puts "View information for #{restaurant.name}: "
  while true
    puts "Would you like to view your [r]eward programs, view [c]ustomer data, or e[x]it this menu? "
    input = get_valid_input(["r", "reward", "c", "customer", "x", "exit"])

    if input == 'r' || input == 'reward'
      puts "\n"
      puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
      puts "\n"
      view_restaurant_reward_data(restaurant)
    elsif input == 'c' || input == 'customer'
      puts "\n"
      puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
      puts "\n"
      view_restaurant_customer_data(restaurant)
    else
      return
    end
  end

end

def view_restaurant_reward_data(restaurant)

  all_rewards = restaurant.get_potential_rewards
  (1..all_rewards.size).each do |i|
    reward = all_rewards[i - 1]
    puts "#{i}: #{reward.label} - Desc: #{reward.reward_description} for customers with a #{reward.requirement} #{reward.reward_type}.downcase rating."
  end
  puts "\n"
  puts 'Choose a number to view detailed data on a reward plan, or e[x]it this menu'
  input = get_valid_input([(1..all_rewards.size).map(&:to_s), 'x', 'exit'].flatten)

  if input == 'x' || input == 'exit'
    return
  else
    active_reward = all_rewards[input.to_i - 1]
  end
  puts "\n"
  puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
  puts "\n"
  puts "Reward data for the #{active_reward.label} reward: "
  puts "label: #{active_reward.label}, type: #{active_reward.reward_type}, requirement: #{active_reward.requirement}, desc: #{active_reward.reward_description}."
  puts "Customers who qualify for this reward: "

  gets.chomp
  puts "---------------------"
  view_restaurant_reward_data(restaurant)

end

def view_restaurant_customer_data(restaurant)

  puts "Viewing customer data: "
  options = ['1: Best customer', '2: Worst customer', '3: Most visits']
  options.each{|i| puts i}
  input = get_valid_input([(1..options.size).map(&:to_s), 'x', 'exit'].flatten)

  if input == '1'
    puts "The higest rated customer at your restaurant is: #{restaurant.best_customer}"
  elsif input == '2'
    puts "The lowest rated customer at your restaurant is : #{restaurant.worst_customer}"
  elsif input == '3'
    puts "The customer who has visted your restaurant the most is #{restaurant.most_visited}"
  end


end

#
