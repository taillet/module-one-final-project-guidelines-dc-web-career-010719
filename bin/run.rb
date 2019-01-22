require_relative '../config/environment'


def write(restaurants)
        puts "What is your customer's name?"
        name = gets.chomp
        # check for typos or create new customer account
        customer = Customer.all.find_or_create_by(name: name)
        puts "How would you rate #{name}'s etiquette?"
        e = gets.chomp
        puts "How would you rate #{name}'s punctuality?"
        p = gets.chomp
        puts "How would you rate #{name}'s tipping?"
        t = gets.chomp
        restaurant.write_review(customer, e, p, t)
        puts "Your review for #{name} was submitted."
end

def run
  # add exit command
  puts "Are you a [c]ustomer or a [r]estaurant?"
  input = gets.chomp

  if input == "c" || input == "customer"
    puts "What's your name?"
    name = gets.chomp
    # add if customer doesnt exist error
    # typo check or create customer account
    # create error for customer without any reviews
    # make this a loop so that the customer can look at other scores after
    # turn score list into helper method
    customer = Customer.all.find_by(name: name)
    puts "Hi, #{name}. Which score would you like to see?"
      puts "1. Etiquette score"
      puts "2. Punctuality score"
      puts "3. Tipping score"
      puts "4. Overall score"
    score = gets.chomp.downcase

      if score == "1" || score == "etiquette score"
        puts customer.get_average_etiquette_score
      elsif score == "2" || score == "punctuality score"
        puts customer.get_average_punctuality_score
      elsif score == "3" || score == "tipping score"
        puts customer.get_average_tipping_score
      elsif score == "4" || score == "overall score"
        puts customer.get_average_rating
      else "Incorrect input. Type in a number or score name."
      end

  elsif input == "r" || input == "restaurant"
    puts "What is the name of your restaurant?"
    name = gets.chomp
    restaurant = Restaurant.all.find_by(name: name)

      while restaurant.nil?
      puts "#{name} doesn't exist."
      puts "Would you like to [c]reate a new restaurant account or [t]ry again?"
      input = gets.chomp
       if input == "c" || input == "create a new restaurant account"
         puts "What is the name of your restaurant?"
         name = gets.chomp
         restaurant = Restaurant.create(name: name)
         break
       elsif input == "t" || input == "try again"
         name = gets.chomp
         restaurant = Restaurant.all.find_by(name: name)
       else
          puts "Incorrect input. Type 'c' to create a new restaurant account or 't' to try again."
        end
      end

      puts "Would you like to write a review? y/n"
      yn = gets.chomp

      while yn != "n"
        if yn == "y" || yn == "yes"
          write(restaurant)
          puts "Would you like to write a review? y/n"
          yn = gets.chomp
        else "Incorrect input. Type 'y' to write a review 'n' to exit."
        end
      end

      if yn == "n" || yn == "no"
        puts "Thank you. Come again."
      end
  end
end

run
