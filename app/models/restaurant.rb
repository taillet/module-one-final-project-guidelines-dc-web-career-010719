
class Restaurant < ActiveRecord::Base

  has_many :reviews
  has_many :customers, through: :reviews

  def write_review(customer, etiquette, punctuality, tipping)
    #overall is int for now, change to float later
    r = Review.create(customer: customer, restaurant: self, etiquette: etiquette, punctuality: punctuality, tipping: tipping, overall: ((etiquette + punctuality + tipping) / 3).round(1))
    r.save
    r
  end

  def create_reward(label, requirement, discount)
    reward = Reward.create(restaurant: self, label: label, requirement: requirement, discount: discount)
    reward.save
    reward
  end

  def self.best_customer
    Customer.all.max_by{|i| i.get_overall_rating}
  end





end
