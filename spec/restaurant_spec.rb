require_relative 'spec_helper'

  describe "Restaurant" do

  let (:checker) {Restaurant.new}
    it 'creates a review instance with the correct customer information' do
      jack = Customer.create(name: "Jack")
      expect(checker.write_review(jack,5,5,5)).to eq(Review.find_by(customer: jack))
    end

    it 'creates a reward instance with the correct information' do
      expect(checker.create_reward("Test", 4, "This is a test reward", "Overall")).to eq(Reward.find_by(label: "Test"))
    end

    it 'allows restaurant to check for potential rewards' do
      a = checker.create_reward("Test", 4, "This is a test reward", "Overall")
      b = checker.create_reward("Test2", 2, "This is a test reward", "Overall")
      c = checker.create_reward("Test3", 3, "This is a test reward", "Overall")
      expect(checker.get_potential_rewards).to eq([a,b,c])
    end

    it 'allows restaurant to find best customer' do
      expect(Restaurant.best_customer).to eq(phil)
    end

# figure out how to run rake db:seef before running tests

end
