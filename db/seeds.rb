require 'csv'
require 'pry'
Customer.destroy_all
Restaurant.destroy_all
Review.destroy_all
Reward.destroy_all

def csv_to_array(file_location)
    csv = CSV::parse(File.open(file_location, 'r') {|f| f.read})
    fields = csv.shift
    fields = fields.map {|f| f.downcase.strip.to_sym}
    csv.collect do |record| Hash[*fields.zip(record).flatten ]
    end
end

customers = csv_to_array('./customers.csv')
restaurants = csv_to_array('./restaurants.csv')
rewards = csv_to_array('./rewards.csv')
reviews = csv_to_array('./reviews.csv')

customers.each do |customer|
  x = Customer.create(username: customer[:username], password: customer[:password])
  x.save
end


restaurants.each do |restaurant|
  x = Restaurant.create(name: restaurant[:name], password: restaurant[:password])
  x.save
end

rewards.each do |reward|
  x = Reward.create(label: reward[:label], restaurant_id: Restaurant.find_by(name: reward[:restaurant_id]).id,
      requirement: reward[:requirement], reward_description: reward[:reward_description],
      reward_type: reward[:reward_type])
  x.save
end

reviews.each do |review|
  overall = 0
  overall = ((review[:etiquette].to_f + review[:punctuality].to_f + review[:tipping].to_f)/3).round(1)
  x = Review.create(customer_id: Customer.find_by(username: review[:customer_name]).id, restaurant_id: Restaurant.find_by(name: review[:restaurant_name]).id,
      etiquette: review[:etiquette], punctuality: review[:punctuality], tipping: review[:tipping],
      overall: overall)
  x.save
end
