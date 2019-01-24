
# ------------------------------------------

def customer_processing
  customer = get_customer

  if customer == 'exit'
    puts 'Goodbye'
    return
  elsif customer == 'new'
    puts 'New account created. Go eat at participating restaurants to start earning rewards!'
    return
  end
  puts "\n"
  puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o "
  puts "\n"
  puts "Welcome, #{customer.username}!"
  puts "\n"
  loop do
    puts 'Would you like to check your [s]cores, view your [r]ewards, or e[x]it?'
    input = get_valid_input(%w[s score scores r reward rewards x exit])

    if %w[s score scores].include?(input)
      view_customer_scores(customer)
    elsif %w[r reward rewards].include?(input)
      view_customer_rewards(customer)
    else
      break
    end
  end
end

# ---------------------

def user_exists?(user)
  customer = Customer.all.find_by(username: user)
  if customer.nil?
    return false
  else
    return true
  end
end

def create_user(user)
  if !user_exists?(user)
    print 'Create a password: '
    pass = STDIN.noecho(&:gets).chomp
    puts "Creating a new customer, #{user}..."
    customer = Customer.create(username: user, password: pass)
  else
    puts "This username already exists. Try another username."
    user = gets.chomp
    create_user(user)
  end
end

def check_customer(name)
  puts "#{name} doesn't exist in our database."
  puts 'Would you like to [c]reate a new customer account, [t]ry again, or e[x]it?'
  input = get_valid_input(['c', 'create', 't', 'try again', 'x', 'exit'])
  if input == 'c' || input == 'create'
    print 'Create a username:'
    user = gets.chomp
    create_user(user)
    return 'new'
  elsif input == 't' || input == 'try again'
    "#{name} doesn't exist in our database. Please enter a correct username."
    get_customer
  elsif input == 'x' || input == 'exit'
    return 'exit'
  end
end

def get_customer
  puts "\n"
  print 'Please enter your username: '
  name = gets.chomp
  customer = Customer.all.find_by(username: name)

  if customer.nil?
    check_customer(name)
  else
    count = 0
    get_password(count, customer)
  end
end

def get_password(count, customer)
  if count == 0
    print 'Please enter your password: '
  elsif count > 0
    print 'Incorrect password, Try again. '
  end
  pass = STDIN.noecho(&:gets).chomp
  count += 1
  if pass == customer.password
    return customer
  elseif count <= 3
    get_password(count, customer)
  elsif count >3
    puts 'Incorrect password, logging off...'
    return exit
  end
end

def list_scores
  puts "Type the number of the score you'd like to see, or [i]nfo for more information on these categories."
  puts "\n"
  puts "o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o o-o"
  puts "\n"
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
  if !customer.get_average_overall_rating.nan?
    if score == '1'
      puts "Your etiquette score: #{customer.get_average_etiquette_score}."
    elsif score == '2'
      puts "Your punctuality score: #{customer.get_average_punctuality_score}."
    elsif score == '3'
      puts "Your tipping score: #{customer.get_average_tipping_score}."
    elsif score == '4'
      puts "Your overall score: #{customer.get_average_overall_rating}."
    end
  else
    puts "You don't have any scores yet. Check again after your next restaurant visit."
  end
end

def view_customer_scores(customer)
  list_scores
  input = get_valid_input(%w[i info 1 2 3 4])

  if input == 'i' || input == 'info'
    about_scores
    puts 'Choose a number 1-4.'
    input = get_valid_input(%w[1 2 3 4])
  end

  get_score(customer, input)
end

def view_customer_rewards(customer)

  puts "\nView rewards by [r]estaurant, or [a]ll?"
  input = get_valid_input(%w[r restaurant a all])

  if ['r', 'restaurant'].include?(input)
    print "Enter restaurant name: "
    r_input = gets.chomp
    if Restaurant.all.find_by(name: r_input).nil?
      puts "Did not find restaurant, searching with no filter..."
      rewards = customer.find_reward_qualifications
    else
      rewards = customer.find_reward_qualifications(restaurant = Restaurant.all.find_by(name: r_input))
    end
  else
    rewards = customer.find_reward_qualifications
  end

  print "\n"
  puts 'You qualify for the following rewards: '
  rewards.each do |i|
    puts "----"
    puts "#{i.restaurant.name}: #{i.label} - Desc: #{i.reward_description}"
  end
  puts "----\n\n"
end
