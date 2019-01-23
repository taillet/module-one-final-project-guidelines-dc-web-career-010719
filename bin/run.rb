require_relative '../config/environment'

# --------------------------
  #helper methods

def get_valid_input(v_array)

  input = gets.chomp.downcase
  while !v_array.include?(input)
    puts "Not a valid input, please try again."
    input = gets.chomp.downcase
  end
  input
end

# ------------------------------------------------
  #run methods

def greeting

  puts "Welcome to --- app"
  puts "Customers can check their ratings and earned rewards,"
  puts "Restaurants can rate customers."

end

def customer_or_restaurant

  puts "Log on as a [c]ustomer or [r]estaurant: "
  input = get_valid_input(['c', 'r', 'customer', 'restaurant'])
  if input == 'c' || input == 'customer'
    'customer'
  else
    'restaurant'
  end

end

def customer_processing

  customer = get_customer

  if customer == 'exit'
    puts "Goodbye"
    return
  elsif customer == 'new'
    puts "New account created. Go eat at participating restaurants to start earning rewards!"
    return
  end

  puts "Welcome #{customer.name}."

  while true
    puts "Would you like to check your [s]cores, view your [r]ewards, or e[x]it?"
    input = get_valid_input(['s', 'score', 'scores', 'r', 'reward', 'rewards', 'x', 'exit'])

    if ['s', 'score', 'scores'].include?(input)
      view_customer_scores(customer)
    elsif ['r', 'reward', 'rewards'].include?(input)
      view_customer_rewards(customer)
    else
      break
    end
  end

end

def restaurant_processing

  restaurant = get_restaurant

  if restaurant == 'exit'
    puts "Goodbye"
    return
  end

  puts "Would you like to [r]eview a customer, or [e]dit your reward program?"
  input = get_valid_input(['r', 'review', 'e', 'edit'])
  if input == 'r' || input == 'review'
    review_customer(restaurant)
  else
    modify_reward_program(restaurant)
  end

end

# --------------------------------------------------
  #customer processing helper methods

def get_customer

  print "Please enter your name: "
  name = gets.chomp
  customer = Customer.all.find_by(name: name)

  if customer.nil?
    puts "#{name} doesn't exist in our database."
    puts "Would you like to [c]reate a new customer account, [t]ry again, or e[x]it?"
    input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
    if input == "c" || input == "create"
      puts "Creating a new customer, #{name}..."
      customer = Customer.create(name: name)
      return 'new'
    elsif input == 'x' || input == 'exit'
      return 'exit'
    end
  end
  customer
end

def list_scores
  puts "Type the number or name of the score you'd like to see, or [i]nfo for more information on these categories."
  puts '1. Etiquette Score'
  puts '2. Punctuality Score'
  puts '3. Tipping Score'
  puts '4. Overall Score'
end

def about_scores
  puts 'Your etiquette score reflects your interactions with restaurant staff.'
  puts 'Your punctuality score reflects how timely you are with your reservations.'
  puts 'Your tipping score reflects how well you tip.'
  puts 'Your overall score is an average of your etiquette, punctuality, and tipping scores.'
  puts "Type 'list' to see your scores or 'exit' to log out."
end

def get_score(customer, score)
  if !customer.get_average_rating.nan?
    if score == '1'
      puts "Your etiquette score: #{customer.get_average_etiquette_score}."
    elsif score == '2'
      puts "Your punctuality score: #{customer.get_average_punctuality_score}."
    elsif score == '3'
      puts "Your tipping score: #{customer.get_average_tipping_score}."
    elsif score == '4'
      puts "Your overall score: #{customer.get_average_rating}."
    end
  else
    puts "You don't have any scores yet. Check again after your next restaurant visit."
  end
end

def view_customer_scores(customer)

  list_scores
  input = get_valid_input(['i', 'info', '1', '2', '3', '4'])

  if input == 'i' || input == 'info'
    about_scores
    puts "Choose a number 1-4."
    input = get_valid_input(['1', '2', '3', '4'])
  end

  get_score(customer, input)

end

def view_customer_rewards(customer)

  puts "You qualify for the following rewards: "
  customer.find_reward_qualifications.each{|i| puts "#{i.restaurant.name}: #{i.label} - Desc: #{i.reward_description}"}

end

# -----------------------------------------------
  #restaurant processing helper methods

def get_restaurant

  print "Please enter your restaurant name: "
  name = gets.chomp
  restaurant = Restaurant.all.find_by(name: name)

  if restaurant.nil?
    puts "#{name} doesn't exist in our database."
    puts "Would you like to [c]reate a new restaurant account, [t]ry again, or e[x]it?"
    input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
    if input == "c" || input == "create"
      puts "Creating a new restaurant, #{name}..."
      restaurant = Restaurant.create(name: name)
    elsif input == 'x' || input == 'exit'
      return 'exit'
    end
  end
  restaurant

end

def review_customer(restaurant)

  puts "What is your customer's name?"
  customer = get_reviewee
  if customer == 'x' || customer == 'exit'
    return
  end

  range = (1..5).map{|i| i.to_s}
  puts "How would you rate #{customer.name}'s etiquette? (1-5)"
  e = get_valid_input(range)
  puts "How would you rate #{customer.name}'s punctuality? (1-5)"
  p = get_valid_input(range)
  puts "How would you rate #{customer.name}'s tipping? (1-5)"
  t = get_valid_input(range)
  restaurant.write_review(customer, e, p, t)
  puts "Your review for #{customer.name} was submitted."

  puts "Would you like to [r]eview another customer, or e[x]it?"
  input = get_valid_input(['r', 'review', 'x', 'exit'])
  if input == 'x' || input == 'exit'
    return
  else
    review_customer(restaurant)
  end

end

def get_reviewee

  name = gets.chomp
  customer = Customer.all.find_by(name: name)

  if customer.nil?
    puts "#{name} doesn't exist in our database."
    puts "Would you like to [c]reate a new customer instance, [t]ry again, or e[x]it?"
    input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
    if input == "c" || input == "create"
      puts "Creating a new customer, #{name}..."
      customer = Customer.create(name: name)
    elsif input == 'x' || input == 'exit'
      return 'exit'
    end
  end
  if !customer.nil?
    customer
  else
    get_reviewee
  end
end

def modify_reward_program(restaurant)

  puts "Modifying the reward program for #{restaurant.name}"
  puts "Do you want to [e]dit an existing reward or [a]dd a new one?"
  input = get_valid_input(['e', 'edit', 'a', 'add'])

  if input == 'e' || input == 'edit'
    choose_reward_to_edit(restaurant)
  else
    add_reward(restaurant)
  end

end

def choose_reward_to_edit(restaurant)

  puts "Editing rewards for #{restaurant.name}..."
  puts "Please be considerate of customers and change rewards infrequently."
  puts "current rewards for this program: "
  all_rewards = restaurant.get_potential_rewards
  for i in (1..all_rewards.size)
    reward = all_rewards[i - 1]
    puts "#{i}: #{reward.label} - Desc: #{reward.reward_description} for customers with a #{reward.requirement} #{reward.reward_type} rating."
  end
  puts "Enter the number of the reward you would like to edit"
  input = get_valid_input((1..all_rewards.size).map{|i| i.to_s})
  active_reward = all_rewards[input.to_i - 1]

  edit_reward(active_reward, restaurant)

end

def edit_reward(active_reward, restaurant)

  puts "Current reward data for the #{active_reward.label} reward: "
  puts "label: #{active_reward.label}, type: #{active_reward.reward_type}, requirement: #{active_reward.requirement}, desc: #{active_reward.reward_description}."
  puts "Enter the new values for this reward: "
  puts "Choose the name for your new reward (example: Platinum Tier, Early Bird)"
  label = gets.chomp
  puts "Choose the customer score your reward should examine (one of Overall/Etiquette/Punctuality/Tipping)"
  type = get_valid_input(['overall', 'etiquette', 'punctuality', 'tipping']).capitalize
  puts "Choose the required score for earning this reward (1.0 - 5.0)"
  req = gets.chomp.to_f
  while !(1.0..5.0).include?(req)
    puts "Not a valid input, please try again."
    req = gets.chomp.to_f
  end
  puts "Enter the reward a customer will receive for meeting these requirements (example: 20% discount, Booking Priority)"
  desc = gets.chomp

  Reward.all.delete(active_reward.id)
  restaurant.create_reward(label, req, desc, type)
  puts "Reward updated!"

end

def add_reward(restaurant)

  puts "Adding new reward..."
  puts "Choose the name for your new reward (example: Platinum Tier, Early Bird)"
  label = gets.chomp
  puts "Choose the customer score your reward should examine (one of Overall/Etiquette/Punctuality/Tipping)"
  type = get_valid_input(['overall', 'etiquette', 'punctuality', 'tipping']).capitalize
  puts "Choose the required score for earning this reward (1.0 - 5.0)"
  req = gets.chomp.to_f
  while !(1.0..5.0).include?(req)
    puts "Not a valid input, please try again."
    req = gets.chomp.to_f
  end
  puts "Enter the reward a customer will receive for meeting these requirements (example: 20% discount, Booking Priority)"
  desc = gets.chomp
  restaurant.create_reward(label, req, desc, type)
  puts "New reward added!"

end

# -----------------------------------------------
  #run function

def run

  greeting

  user_type = customer_or_restaurant

  if user_type == 'customer'
    customer_processing
  elsif user_type == 'restaurant'
    restaurant_processing
  end

  puts "Thank you for using the --- app!"

end

run

#

# notes:
  # -didnt implement anything with restaurant specific reviews, everything still defaults to global
  # -can maybe combine get_customer and get_restaurant into one function, but maybe not
