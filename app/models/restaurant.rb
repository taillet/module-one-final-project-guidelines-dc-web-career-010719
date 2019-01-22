
class Restaurant < ActiveRecord::Base

  has_many :reviews
  has_many :customers, through: :reviews
  has_many :rewards

  def write_review(customer, es, ps, ts)
    overall = ((es.to_f + ps.to_f + ts.to_f) / 3).round(1)
    r = Review.create(customer: customer, restaurant: self, etiquette: es, punctuality: ps, tipping: ts, overall: overall)
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
