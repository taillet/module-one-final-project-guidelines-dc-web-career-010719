
require 'pry'
class Customer < ActiveRecord::Base

  has_many :reviews
  has_many :restaurants, through: :reviews

  def get_all_customer_reviews
    #helper function that returns all reviews involving the customer
    Review.all.select{|r| r.customer == self}
  end

  def get_reviews_by_restaurant(restaurant)
    #returns an array of all reviews of the customer with a specific restaurant
    self.get_all_customer_reviews.select {|i| i.restaurant == restaurant}
  end

  def get_visits_by_restaurant(restaurant)
    #returns the number of times the user has visited the passed restaurant
    self.get_reviews_by_restaurant(restaurant).size
  end

  def get_average_overall_rating
    #returns the value (float) of a users average overall ratings for all restaurant visits
    (self.get_all_customer_reviews.map{|i| i.overall}.inject{|sum, x| sum + x}.to_f / self.get_all_customer_reviews.size).round(1)
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

  def find_reward_qualifications(restaurant = nil, type = nil)
    #shows rewards that a customer qualifies for with optional parameters for restaurant and type

    potential_rewards = Reward.all
    qualified = []

    if !restaurant.nil?
      potential_rewards = restaurant.get_potential_rewards
    end

    if !type.nil?
      potential_rewards = potential_rewards.select{|i| i.reward_type == type}
    end

    potential_rewards.each do |r|
      if r.reward_type == "Overall"
        score = self.get_average_overall_rating
        qualified << r if score >= r.requirement
      elsif r.reward_type == "Etiquette"
        score = self.get_average_etiquette_score
        qualified << r if score >= r.requirement
      elsif r.reward_type == "Punctuality"
        score = self.get_average_punctuality_score
        qualified << r if score >= r.requirement
      elsif r.reward_type == "Tipping"
        score = self.get_average_tipping_score
        qualified << r if score >= r.requirement
      end
    end
    qualified
  end

end
