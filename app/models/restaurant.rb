
class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :customers, through: :reviews
  has_many :rewards

  def write_review(customer, es, t, bill, paid)
    #called by the restaurant with a customer object and the content of the review, creates and saves a Review instance
    ps = punc_score(t.to_f)
    ts = tip_score(bill.to_f, paid.to_f)
    overall = ((es.to_f + ps.to_f + ts.to_f) / 3).round(1)
    r = Review.create(customer: customer, restaurant: self, etiquette: es, punctuality: ps, tipping: ts, overall: overall)
    r.save
    r
  end

  def punc_score(time)
    #helper function to translate minutes late/early into a 1-5 score
    score = if time >= 20
              1
            elsif (15..20).cover?(time)
              2
            elsif  (10..15).cover?(time)
              3
            elsif  (5..10).cover?(time)
              4
            else
              5
            end
    score
  end

  def tip_score(bill, paid)
    #helper function to translate amount tipped into a 1-5 score
    percent = ((paid - bill) / bill) * 100
    if percent >= 20
      score = 5
    elsif (15..20).cover?(percent)
      score = 4
    elsif (10..15).cover?(percent)
      score = 3
    elsif (5..10).cover?(percent)
      score = 2
    elsif (0..5).cover?(percent)
      score = 1
    end
    score
  end

  def create_reward(label, requirement, reward_description, reward_type)
    #creates an instance of Reward tied to the restaurant calling the function
    reward = Reward.create(restaurant: self, label: label, requirement: requirement, reward_description: reward_description, reward_type: reward_type)
    reward.save
    reward
  end

  def get_potential_rewards
    #returns an array of all the rewards tied to the restaurant calling the function
    Reward.all.select { |i| i.restaurant == self }
  end

  def list_potential_rewards
    #puts out each reward and its details for the calling restaurant
    get_potential_rewards.each { |i| puts "#{i.label} - Desc: #{i.reward_description} for customers with a #{i.requirement} #{i.reward_type} rating." }
  end

  def get_all_restaurant_reviews
    #helper function that gathers all reviews for the restaurant that calls the function
    Review.all.select{ |i| i.restaurant == self}
  end

  def get_all_customer_usernames
    self.reviews.map(&:customer_id).uniq.map{|id| Customer.find_by(id: id).username}
  end

  def find_qualified_customers_by_reward(reward)
    #returns a list of customers who qualify for the given reward
    self.customers.uniq.select{ |i| i.check_single_reward_status(reward)}
  end

  def best_customer
    #returns a restaurant's highest rated (by overall) customer
    all_reviews = self.get_all_restaurant_reviews
    if all_reviews.size == 0
      "None"
    else
      all_reviews.max_by {|i| i.customer.get_average_overall_rating}.customer.username
    end
  end

  def worst_customer
    #returns a restaurant's lowest rated (by overall) customer
    all_reviews = self.get_all_restaurant_reviews
    if all_reviews.size == 0
      "None"
    else
      all_reviews.min_by {|i| i.customer.get_average_overall_rating}.customer.username
    end
  end

  def most_visited
    #returns the name of the customer that visited the restaurant calling the function the most times
    all_reviews = self.get_all_restaurant_reviews
    if all_reviews.size == 0
      "None"
    else
      all_reviews.max_by {|i| i.customer.username}.customer.username
    end
  end

end
