
class CreateRewardTable < ActiveRecord::Migration[4.2]

  def change
    create_table :rewards do |t|
      t.string :label
      t.integer :restaurant_id
      t.integer :requirement
      t.integer :discount
    end
  end

end

Label  | restaurant | attr | requirement | rewardstring |
----------------------------------------------
                        ovr  4               "20% discount"
                        pun
five guys booking priority pun 4          "Priority booking"

# filter by restaurant, attribute (overall) order by requirement desc limit 1 (.first)
