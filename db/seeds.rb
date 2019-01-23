Customer.destroy_all
Restaurant.destroy_all
Review.destroy_all
Reward.destroy_all


phil = Customer.create(name: "Phil")
heloise = Customer.create(name: "Heloise")
paul = Customer.create(name:"Paul")

mcd = Restaurant.create(name:"McDonalds")
chip = Restaurant.create(name:"Chipotle")
five = Restaurant.create(name:"Five Guys")

mcd.write_review(phil, 4, 4, 4)
mcd.write_review(phil, 3, 3, 4)
five.write_review(phil, 4, 5, 3)
chip.write_review(heloise, 4, 4, 3)
mcd.write_review(heloise, 2, 5, 1)
five.write_review(paul, 1, 5, 5)
mcd.write_review(paul, 3, 5, 3)

mcd_plat = Reward.create(label: "Platinum Tier", restaurant: mcd, requirement: 4.0, reward_type: "Overall", reward_description: "20% Discount")
mcd_gold = Reward.create(label: "Gold Tier", restaurant: mcd, requirement: 3.5, reward_type: "Overall", reward_description: "10% Discount")
five_plat = Reward.create(label: "Platinum Tier", restaurant: five, requirement: 4.0, reward_type: "Overall", reward_description: "20% Discount")
five_pun = Reward.create(label: "Five On Time", restaurant: five, requirement: 4.0, reward_type: "Punctuality", reward_description: "Booking Priority")

# require 'csv'
# def csv_to_array(file_location)
#     csv = CSV::parse(File.open(file_location, 'r') {|f| f.read })
#     fields = csv.shift
#     fields = fields.map {|f| f.downcase.gsub(" ", "_")}
#     csv.collect { |record| Hash[*fields.zip(record).flatten ] }
# end
