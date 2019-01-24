class Restaurant < ActiveRecord::Base
  has_many :reviews
  has_many :customers, through: :reviews
  has_many :rewards

  # eventually, ps and ts could be calculated by a method rather than input by worker
  # ps could be time of reservation vs. time arrived
  # ts could ask for bill total, and bill paid and calculate tip percent

  # def write_review(customer, es, ps, ts)
  #   overall = ((es.to_f + ps.to_f + ts.to_f) / 3).round(1)
  #   r = Review.create(customer: customer, restaurant: self, etiquette: es, punctuality: ps, tipping: ts, overall: overall)
  #   r.save
  #   r
  # end

  def write_review(customer, es, t, bill, paid)
    ps = punc_score(t.to_f)
    ts = tip_score(bill.to_f, paid.to_f)
    overall = ((es.to_f + ps.to_f + ts.to_f) / 3).round(1)
    r = Review.create(customer: customer, restaurant: self, etiquette: es, punctuality: ps, tipping: ts, overall: overall)
    r.save
    r
  end

  def punc_score(time)
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
    reward = Reward.create(restaurant: self, label: label, requirement: requirement, reward_description: reward_description, reward_type: reward_type)
    reward.save
    reward
  end

  def get_potential_rewards
    Reward.all.select { |i| i.restaurant == self }
  end

  def list_potential_rewards
    get_potential_rewards.each { |i| puts "#{i.label} - Desc: #{i.reward_description} for customers with a #{i.requirement} #{i.reward_type} rating." }
  end

  def self.best_customer
    # global, could make for each restaurant
    Customer.all.max_by(&:get_average_overall_rating)
  end

  def self.worst_customer
    Customer.all.min_by(&:get_average_overall_rating)
  end

  # best/worst by restaurant
  # most visited/reviewed
  # best x by self
end
