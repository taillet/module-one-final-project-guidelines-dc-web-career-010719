Customer.destroy_all
Restaurant.destroy_all
Review.destroy_all


phil = Customer.create("Phil")
heloise = Customer.create("Heloise")
paul = Customer.create("Paul")

mcd = Restaurant.create("McDonalds")
chip = Restaurant.create("Chipotle")
five = Restaurant.create("Five Guys")

mcd.write_review(phil, 5, 5, 2)
five.write_review(phil, 4, 5, 3)
chip.write_review(heloise, 4, 4, 3)
mcd.write_review(heloise, 2, 5, 1)
five.write_review(paul, 1, 5, 5)
mcd.write_review(paul, 3, 5, 3)
