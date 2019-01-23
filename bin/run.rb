require_relative '../config/environment'
#
# # maybe default to global (multi restaurant) score if
# # customer has less than 2 visits at your restaurant,
# # then show restaurant average
#
# def write(restaurant)
#   puts "What is your customer's name?"
#   name = gets.chomp
#   customer = Customer.all.find_by(name: name)
#
#   while customer.nil?
#     puts "#{name} doesn't exist."
#     puts "Would you like to [c]reate a new customer account or [t]ry again?"
#     input = gets.chomp
#     if input == "c" || input == "create a new customer account"
#       puts "What is the customer's name?"
#       name = gets.chomp
#       customer = Customer.create(name: name)
#       break
#     elsif input == 't' || input == 'try again'
#       puts "What is the customer's name?"
#       name = gets.chomp
#       customer = Customer.all.find_by(name: name)
#     else
#       puts "Incorrect input. Type 'c' to create a new customer account or 't' to try again."
#      end
#   end
#
#   puts "How would you rate #{name}'s etiquette?"
#   e = gets.chomp
#   puts "How would you rate #{name}'s punctuality?"
#   p = gets.chomp
#   puts "How would you rate #{name}'s tipping?"
#   t = gets.chomp
#   restaurant.write_review(customer, e, p, t)
#   puts "Your review for #{name} was submitted."
# end
#
# def get_score(customer, score)
#   if !customer.get_average_rating.nan?
#     if score == '1' || score == 'etiquette score'
#       puts "Your etiquette score: #{customer.get_average_etiquette_score}."
#     elsif score == '2' || score == 'punctuality score'
#       puts "Your punctuality score: #{customer.get_average_punctuality_score}."
#     elsif score == '3' || score == 'tipping score'
#       puts "Your tipping score: #{customer.get_average_tipping_score}."
#     elsif score == '4' || score == 'overall score'
#       puts "Your overall score: #{customer.get_average_rating}."
#     else
#       puts 'Incorrect input. Type in a number or score name.'
#     end
#   else
#     puts "You don't have any scores yet. Check again after your next restaurant visit."
#   end
# end
#
# def list_scores
#   puts "Type the number or name of the score you'd like to see."
#   puts '1. Etiquette Score'
#   puts '2. Punctuality Score'
#   puts '3. Tipping Score'
#   puts '4. Overall Score'
#   puts "Type 'about' to learn more about these scores."
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
# def run
#   # add exit command
#   puts 'Are you a [c]ustomer or a [r]estaurant?'
#   input = gets.chomp
#
#   if input == 'c' || input == 'customer'
#     puts "What's your name?"
#     name = gets.chomp
#     # add if customer doesnt exist error
#     # typo check or create customer account
#     # create error for customer without any reviews
#     # make this a loop so that the customer can look at other scores after
#     # turn score list into helper method
#     customer = Customer.all.find_by(name: name)
#     while customer.nil?
#       puts "#{name} doesn't exist."
#       puts 'Would you like to [c]reate a new customer account or [t]ry again?'
#       input = gets.chomp
#       if input == 'c' || input == 'create a new customer account'
#         puts 'What is your name?'
#         name = gets.chomp
#         customer = Customer.create(name: name)
#         break
#       elsif input == 't' || input == 'try again'
#         puts 'What is your name?'
#         name = gets.chomp
#         customer = Customer.all.find_by(name: name)
#       else
#         puts "Incorrect input. Type 'c' to create a new customer account or 't' to try again."
#        end
#     end
#     puts "To see a list of scores you can access. Type 'list'. To exit, type 'exit.'"
#     type = gets.chomp
#
#     while type != 'exit'
#       if type == 'list'
#         list_scores
#         type = gets.chomp
#         if type == 'about'
#           about_scores
#           type = gets.chomp
#         elsif type != 'exit'
#           get_score(customer, type)
#           puts "Type 'list' to see other scores or 'exit' to log out."
#           type = gets.chomp
#       end
#     end
#   end
#
#   elsif input == 'r' || input == 'restaurant'
#     puts 'What is the name of your restaurant?'
#     name = gets.chomp
#     restaurant = Restaurant.all.find_by(name: name)
#
#     while restaurant.nil?
#       puts "#{name} doesn't exist."
#       puts 'Would you like to [c]reate a new restaurant account or [t]ry again?'
#       input = gets.chomp
#       if input == 'c' || input == 'create a new restaurant account'
#         puts 'What is the name of your restaurant?'
#         name = gets.chomp
#         restaurant = Restaurant.create(name: name)
#         break
#       elsif input == 't' || input == 'try again'
#         puts 'What is the name of your restaurant?'
#         name = gets.chomp
#         restaurant = Restaurant.all.find_by(name: name)
#       else
#         puts "Incorrect input. Type 'c' to create a new restaurant account or 't' to try again."
#        end
#     end
#
#     puts 'Would you like to write a review? y/n'
#     yn = gets.chomp
#
#     while yn != 'n'
#       if yn == 'y' || yn == 'yes'
#         write(restaurant)
#         puts 'Would you like to write a review? y/n'
#         yn = gets.chomp
#       else "Incorrect input. Type 'y' to write a review 'n' to exit."
#       end
#     end
#
#     puts 'Thank you. Come again.' if yn == 'n' || yn == 'no'
#   end
# end
#
# run






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

  review_customer(restaurant)

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
  customer.find_reward_qualifications.each{|i| puts "#{i.restaurant.name}: #{i.label} - Discount: #{i.discount}"}

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
  name = gets.chomp
  customer = Customer.all.find_or_create_by(name: name)

  range = (1..5).map{|i| i.to_s}
  puts "How would you rate #{name}'s etiquette? (1-5)"
  e = get_valid_input(range)
  puts "How would you rate #{name}'s punctuality? (1-5)"
  p = get_valid_input(range)
  puts "How would you rate #{name}'s tipping? (1-5)"
  t = get_valid_input(range)
  restaurant.write_review(customer, e, p, t)
  puts "Your review for #{name} was submitted."

  puts "Would you like to [r]eview another customer, or e[x]it?"
  input = get_valid_input(['r', 'review', 'x', 'exit'])
  if input == 'x' || input == 'exit'
    return
  else
    review_customer(restaurant)
  end

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
  # -removed option to choose to create a new user when reviewing as restaurant, now auto-creates a new customer if none -maybe add that back?
  # -can maybe combine get_customer and get_restaurant into one function, but maybe not
