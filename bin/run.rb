require_relative '../config/environment'

# maybe default to global (multi restaurant) score if
# customer has less than 2 visits at your restaurant,
# then show restaurant average

def write(restaurant)
  puts "What is your customer's name?"
  name = gets.chomp
  customer = Customer.all.find_by(name: name)

  while customer.nil?
    puts "#{name} doesn't exist."
    puts "Would you like to [c]reate a new customer account or [t]ry again?"
    input = gets.chomp
    if input == "c" || input == "create a new customer account"
      puts "What is the customer's name?"
      name = gets.chomp
      customer = Customer.create(name: name)
      break
    elsif input == 't' || input == 'try again'
      puts "What is the customer's name?"
      name = gets.chomp
      customer = Customer.all.find_by(name: name)
    else
      puts "Incorrect input. Type 'c' to create a new customer account or 't' to try again."
     end
  end

  puts "How would you rate #{name}'s etiquette?"
  e = gets.chomp
  puts "How would you rate #{name}'s punctuality?"
  p = gets.chomp
  puts "How would you rate #{name}'s tipping?"
  t = gets.chomp
  restaurant.write_review(customer, e, p, t)
  puts "Your review for #{name} was submitted."
end

def get_score(customer, score)
  if !customer.get_average_rating.nan?
    if score == '1' || score == 'etiquette score'
      puts "Your etiquette score: #{customer.get_average_etiquette_score}."
    elsif score == '2' || score == 'punctuality score'
      puts "Your punctuality score: #{customer.get_average_punctuality_score}."
    elsif score == '3' || score == 'tipping score'
      puts "Your tipping score: #{customer.get_average_tipping_score}."
    elsif score == '4' || score == 'overall score'
      puts "Your overall score: #{customer.get_average_rating}."
    else
      puts 'Incorrect input. Type in a number or score name.'
    end
  else
    puts "You don't have any scores yet. Check again after your next restaurant visit."
  end
end

def list_scores
  puts "Type the number or name of the score you'd like to see."
  puts '1. Etiquette Score'
  puts '2. Punctuality Score'
  puts '3. Tipping Score'
  puts '4. Overall Score'
  puts "Type 'about' to learn more about these scores."
end

def about_scores
  puts 'Your etiquette score reflects your interactions with restaurant staff.'
  puts 'Your punctuality score reflects how timely you are with your reservations.'
  puts 'Your tipping score reflects how well you tip.'
  puts 'Your overall score is an average of your etiquette, punctuality, and tipping scores.'
  puts "Type 'list' to see your scores or 'exit' to log out."
end

def run
  # add exit command
  puts 'Are you a [c]ustomer or a [r]estaurant?'
  input = gets.chomp

  if input == 'c' || input == 'customer'
    puts "What's your name?"
    name = gets.chomp
    # add if customer doesnt exist error
    # typo check or create customer account
    # create error for customer without any reviews
    # make this a loop so that the customer can look at other scores after
    # turn score list into helper method
    customer = Customer.all.find_by(name: name)
    while customer.nil?
      puts "#{name} doesn't exist."
      puts 'Would you like to [c]reate a new customer account or [t]ry again?'
      input = gets.chomp
      if input == 'c' || input == 'create a new customer account'
        puts 'What is your name?'
        name = gets.chomp
        customer = Customer.create(name: name)
        break
      elsif input == 't' || input == 'try again'
        puts 'What is your name?'
        name = gets.chomp
        customer = Customer.all.find_by(name: name)
      else
        puts "Incorrect input. Type 'c' to create a new customer account or 't' to try again."
       end
    end
    puts "To see a list of scores you can access. Type 'list'. To exit, type 'exit.'"
    type = gets.chomp

    while type != 'exit'
      if type == 'list'
        list_scores
        type = gets.chomp
        if type == 'about'
          about_scores
          type = gets.chomp
        elsif type != 'exit'
          get_score(customer, type)
          puts "Type 'list' to see other scores or 'exit' to log out."
          type = gets.chomp
      end
    end
  end

  elsif input == 'r' || input == 'restaurant'
    puts 'What is the name of your restaurant?'
    name = gets.chomp
    restaurant = Restaurant.all.find_by(name: name)

    while restaurant.nil?
      puts "#{name} doesn't exist."
      puts 'Would you like to [c]reate a new restaurant account or [t]ry again?'
      input = gets.chomp
      if input == 'c' || input == 'create a new restaurant account'
        puts 'What is the name of your restaurant?'
        name = gets.chomp
        restaurant = Restaurant.create(name: name)
        break
      elsif input == 't' || input == 'try again'
        puts 'What is the name of your restaurant?'
        name = gets.chomp
        restaurant = Restaurant.all.find_by(name: name)
      else
        puts "Incorrect input. Type 'c' to create a new restaurant account or 't' to try again."
       end
    end

    puts 'Would you like to write a review? y/n'
    yn = gets.chomp

    while yn != 'n'
      if yn == 'y' || yn == 'yes'
        write(restaurant)
        puts 'Would you like to write a review? y/n'
        yn = gets.chomp
      else "Incorrect input. Type 'y' to write a review 'n' to exit."
      end
    end

    puts 'Thank you. Come again.' if yn == 'n' || yn == 'no'
  end
end

run
