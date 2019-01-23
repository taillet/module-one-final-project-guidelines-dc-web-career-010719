
class Restaurant < ActiveRecord::Base

  has_many :reviews
  has_many :customers, through: :reviews
  has_many :rewards

  # eventually, ps and ts could be calculated by a method rather than input by worker
  # ps could be time of reservation vs. time arrived
  # ts could ask for bill total, and bill paid and calculate tip percent

  def write_review(customer, es, ps, ts)
    overall = ((es.to_f + ps.to_f + ts.to_f) / 3).round(1)
    r = Review.create(customer: customer, restaurant: self, etiquette: es, punctuality: ps, tipping: ts, overall: overall)
    r.save
    r
  end

  def create_reward(label, requirement, reward_description, reward_type)
    reward = Reward.create(restaurant: self, label: label, requirement: requirement, reward_description: reward_description, reward_type: reward_type)
    reward.save
    reward
  end

  def get_potential_rewards
    Reward.all.select{|i| i.restaurant == self}
  end

  def list_potential_rewards
    self.get_potential_rewards.each{|i| puts i}
  end

  def self.best_customer
    #global, could make for each restaurant
    Customer.all.max_by{|i| i.get_average_overall_rating}
  end

  def self.worst_customer
    Customer.all.min_by{|i| i.get_average_overall_rating}
  end

  #best/worst by restaurant
  #most visited/reviewed
  #best x by self

end
