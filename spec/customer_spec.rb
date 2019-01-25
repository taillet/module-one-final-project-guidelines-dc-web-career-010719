require_relative 'spec_helper'

  describe "Customer" do

  let (:checker) {Customer.new}
    it 'shows customer reviews for a given customer' do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      expect(phil.get_all_customer_reviews).to eq(Review.all.select {|review| review.customer == phil})
      expect(heloise.get_all_customer_reviews).to eq(Review.all.select {|review| review.customer == heloise})
    end

    it "shows customer their reviews by restaurant" do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      mcd = Restaurant.find_by(name: "McDonalds")
      expect(phil.get_reviews_by_restaurant(mcd)).to eq(phil.get_all_customer_reviews.select {|review| review.restaurant == mcd})
      expect(heloise.get_reviews_by_restaurant(mcd)).to eq(heloise.get_all_customer_reviews.select {|review| review.restaurant == mcd})
    end

    it 'shows number of visits customer has made to a given restaurant ' do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      dos = Restaurant.find_by(name: "Dos Toros")
      mcd = Restaurant.find_by(name: "McDonalds")
      expect(phil.get_visits_by_restaurant(dos)).to eq(1)
      expect(heloise.get_visits_by_restaurant(mcd)).to eq(0)
    end

    it 'shows average overall rating for a given customer' do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      expect(phil.get_average_overall_rating).to eq(3.5)
      expect(heloise.get_average_overall_rating).to eq(3.0)
    end

    # it "shows a customer's average overall rating for a given restaurant" do
    #   phil = Customer.find_by(username: "Phil")
    #   heloise = Customer.find_by(username: "Heloise")
    #   mcd = Restaurant.find_by(name: "McDonalds")
    #   expect(phil.get_average_rating_by_restaurant(mcd)).to eq(4.2)
    #   expect(heloise.get_average_rating_by_restaurant(mcd)).to eq(3.0)
    # end

    it "shows a customer's average etiquette score" do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      mcd = Restaurant.find_by(name: "McDonalds")
      expect(phil.get_average_etiquette_score).to eq(4.0)
      expect(heloise.get_average_etiquette_score).to eq(4.5)
    end

    it "shows a customer's average punctuality score" do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      mcd = Restaurant.find_by(name: "McDonalds")
      expect(phil.get_average_punctuality_score).to eq(3.5)
      expect(heloise.get_average_punctuality_score).to eq(2.5)
    end

    it "shows a customer's average tipping score" do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      mcd = Restaurant.find_by(name: "McDonalds")
      expect(phil.get_average_tipping_score).to eq(3.0)
      expect(heloise.get_average_tipping_score).to eq(2.0)
    end

    it "shows all rewards that a customer qualifies for based on their scores" do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      mcd = Restaurant.find_by(name: "McDonalds")
      expect(heloise.find_reward_qualifications(restaurant = mcd, type = "Overall")).to eq([Reward.find_by(restaurant_id: 5, label: "Silver Tier")])
    end

    it "returns empty array if the customer doesn't qualify for any rewards" do
      phil = Customer.find_by(username: "Phil")
      heloise = Customer.find_by(username: "Heloise")
      five = Restaurant.find_by(name: "Five Guys")
      expect(heloise.find_reward_qualifications(restaurant = five, type = "punctuality")).to eq([])
    end
end
