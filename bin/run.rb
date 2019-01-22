require_relative '../config/environment'


def write
        puts "What is your customer's name?"
        name = gets.chomp
        puts "How would you rate #{name}'s etiquette?"
        e = gets.chomp
        puts "How would you rate #{name}'s punctuality?"
        p = gets.chomp
        puts "How would you rate #{name}'s tipping?"
        t = gets.chomp
        self.write_review(name, e, p, t)
        puts "Your review for #{name} was submitted."
end

def run
  puts "Are you a [c]ustomer or a [r]estaurant?"
  input = gets.chomp

  if input == "c" || input == "customer"
    puts "What's your name?"
    name = gets.chomp
    puts "Hi, #{name}. Which score would you like to see?"
      puts "1. Etiquette score"
      puts "2. Punctuality score"
      puts "3. Tipping score"
      puts "4. Overall score"
    score = gets.chomp.downcase

      if score == "1" || score == "etiquette score"
      elsif score == "2" || score == "punctuality score"
      elsif score == "3" || score == "tipping score"
      elsif score == "4" || score == "overall score"
      else "Incorrect input. Type in a number or score name."
      end


  elsif input == "r" || input == "restaurant"
    puts "What is the name of your restaurant?"
    restaurant = gets.chomp

      while !Restaurant.all.include?(restaurant)
      puts "#{restaurant} doesn't exist."
      puts "Would you like to [c]reate a new restaurant account or [t]ry again?"
      input = gets.chomp
       if input == "c" || input == "create a new restaurant account"
         puts "What is the name of your restaurant?"
         restaurant = gets.chomp
         Restaurant.create(name: restaurant)
         break
       elsif input == "t" || input == "try again"
         restaurant = gets.chomp
       else
          puts "Incorrect input. Type 'c' to create a new restaurant account or 't' to try again."
        end
      end

      puts "Would you like to write a review? y/n"
      yn = gets.chomp

      if yn == "n" || yn == "no"
        puts "Thank you. Come again."
      end

      while yn != "n"
        if yn == "y" || yn == "yes"
          write
        else "Incorrect input. Type 'y' to write a review 'n' to exit."
        end
      end
  end
end

run
