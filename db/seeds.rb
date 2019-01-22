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

mcd.write_review(phil, 5, 5, 2)
five.write_review(phil, 4, 5, 3)
chip.write_review(heloise, 4, 4, 3)
mcd.write_review(heloise, 2, 5, 1)
five.write_review(paul, 1, 5, 5)
mcd.write_review(paul, 3, 5, 3)

mcd_plat = Reward.create(label: "Platinum Tier", restaurant: mcd, requirement: 4.0, discount: 20)
mcd_gold = Reward.create(label: "Gold Tier", restaurant: mcd, requirement: 3.5, discount: 10)
five_plat = Reward.create(label: "Platinum Tier", restaurant: five, requirement: 4.0, discount: 20)
