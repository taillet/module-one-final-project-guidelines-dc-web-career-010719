require_relative 'spec_helper'
describe 'Restaurant' do
  let (:checker) { Restaurant.new }
  it 'creates a review instance with the correct customer information' do
    jack = Customer.create(username: 'Jack', password: 1)
    expect(checker.write_review(jack, 5, 0, 15, 20)).to eq(Review.find_by(customer: jack))
  end

  it 'creates a reward instance with the correct information' do
    expect(checker.create_reward('Test', 4, 'This is a test reward', 'Overall')).to eq(Reward.find_by(label: 'Test'))
  end

  it 'allows restaurant to check for potential rewards' do
    a = checker.create_reward('Test', 4, 'This is a test reward', 'Overall')
    b = checker.create_reward('Test2', 2, 'This is a test reward', 'Overall')
    c = checker.create_reward('Test3', 3, 'This is a test reward', 'Overall')
    expect(checker.get_potential_rewards).to eq([a, b, c])
  end

  it 'allows restaurant to find best customer' do
    pop = Restaurant.find_by(name: "Popeyes")
    expect(pop.best_customer).to eq(Customer.find_by(username: 'Kyle').username)
  end

  it 'allows restaurant to find worst customer' do
    pop = Restaurant.find_by(name: "Popeyes")
    expect(pop.worst_customer).to eq(Customer.find_by(username: 'Heloise').username)
  end
end
