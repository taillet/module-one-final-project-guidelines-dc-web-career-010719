
class Customer < ActiveRecord::Base

  has_many :reviews
  has_many :restaurants, through: :reviews

  def get_all_customer_reviews
    Review.all.select{|r| r.customer == self}
  end

  def get_overall_rating
    (self.get_all_customer_reviews.map{|i| i.overall}.inject{|sum, x| sum + x} / self.get_all_customer_reviews.size).round(1)
  end

end
