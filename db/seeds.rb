require 'csv'
require 'pry'
Customer.destroy_all
Restaurant.destroy_all
Review.destroy_all
Reward.destroy_all
#
# #
# #
customers = CSV.parse("customers.csv", headers: true)


# CSV.foreach("path/to/file.csv") do |row|
#   # use row here...
# end

# phil = Customer.create(username: 'Phil', password: '1')
# heloise = Customer.create(username: 'Heloise', password: 'pass')
# paul = Customer.create(username: 'Paul', password: '1111')

mcd = Restaurant.create(name: 'McDonalds', password: '111')
chip = Restaurant.create(name: 'Chipotle', password: '222')
five = Restaurant.create(name: 'Five Guys', password: '333')

mcd.write_review(phil, 4, 0, 20, 25)
mcd.write_review(phil, 3, 0, 10, 11)
five.write_review(phil, 4, -5, 3, 4)
chip.write_review(heloise, 4, 3, 8, 12)
mcd.write_review(heloise, 2, 15, 3, 5)
five.write_review(paul, 1, 25, 5, 5)
mcd.write_review(paul, 3, 7, 3, 5)

mcd_plat = Reward.create(label: 'Platinum Tier', restaurant: mcd, requirement: 4.0, reward_type: 'Overall', reward_description: '20% Discount')
mcd_gold = Reward.create(label: 'Gold Tier', restaurant: mcd, requirement: 3.5, reward_type: 'Overall', reward_description: '10% Discount')
five_plat = Reward.create(label: 'Platinum Tier', restaurant: five, requirement: 4.0, reward_type: 'Overall', reward_description: '20% Discount')
five_pun = Reward.create(label: 'Five On Time', restaurant: five, requirement: 4.0, reward_type: 'Punctuality', reward_description: 'Booking Priority')

# require 'csv'
# def csv_to_array(file_location)
#     csv = CSV::parse(File.open(file_location, 'r') {|f| f.read })
#     fields = csv.shift
#     fields = fields.map {|f| f.downcase.gsub(" ", "_")}
#     csv.collect { |record| Hash[*fields.zip(record).flatten ] }
# end
