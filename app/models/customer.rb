
class Customer < ActiveRecord::Base

  has_many :reviews
  has_many :restaurants, through: :reviews

  def get_all_customer_reviews
    #helper function that returns all reviews involving the customer
    Review.all.select{|r| r.customer == self}
  end

  def get_reviews_by_restaurant(restaurant)
    #returns an array of all reviews of the customer with a specific restaurant
    self.get_all_customer_reviews.map{|i| i.restaurant == restaurant}
  end

  def get_average_rating
    #returns the value (float) of a users average overall ratings for all restaurant visits
    (self.get_all_customer_reviews.map{|i| i.overall}.inject{|sum, x| sum + x}.to_f / self.get_all_customer_reviews.size).round(1)
  end

  def get_visits_by_restaurant(restaurant)
    #returns the number of times the user has visited the passed restaurant
    self.get_all_customer_reviews.size
  end

  def get_average_rating_by_restaurant(restaurant)
    #returns value (float) of a customers overall rating at a specific restaurant
    (self.get_reviews_by_restaurant(restaurant).inject{|sum, i| sum + i}.to_f / self.get_visits_by_restaurant(restaurant)).round(1)
  end

  def get_average_etiquette_score
    #returns the value (float) of all customers etiquette ratings
    (self.get_all_customer_reviews.map{|i| i.etiquette}.inject{|sum, x| sum + x}.to_f / self.get_all_customer_reviews.size).round(1)
  end

  def get_average_punctuality_score
    #returns the value (float) of all customers punctuality ratings
    (self.get_all_customer_reviews.map{|i| i.punctuality}.inject{|sum, x| sum + x}.to_f / self.get_all_customer_reviews.size).round(1)
  end

  def get_average_tipping_score
    #returns the value (float) of all customers tip score ratings
    (self.get_all_customer_reviews.map{|i| i.tipping}.inject{|sum, x| sum + x}.to_f / self.get_all_customer_reviews.size).round(1)
  end

  def find_reward_qualifications
    #shows all rewards that a customer qualifies for

    #higher tier should obsolete lower tiers
    score = self.get_average_rating
    Reward.all.select{|i| score >= i.requirement}
  end

  def find_reward_qualifications_by_restaurant(restaurant)
    #shows rewards that a customer qualifies for, with a specific restaurant
    self.find_reward_qualifications.select{|i| i.restaurant == restaurant}
  end

end
