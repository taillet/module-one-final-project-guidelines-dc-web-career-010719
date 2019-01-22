
class Restaurant < ActiveRecord::Base

  has_many :reviews
  has_many :customers, through: :reviews

  def write_review(customer, etiquette, punctuality, tipping)
    #overall is int for now, change to float later
    r = Review.create(customer: customer, restaurant: self, etiquette: etiquette, punctuality: punctuality, tipping: tipping, overall: ((etiquette + punctuality + tipping) / 3).round(1))
    r.save
    r
  end

  def create_reward

  end

end
