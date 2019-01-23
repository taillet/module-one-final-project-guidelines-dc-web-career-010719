
class AddRewardTypeToReward < ActiveRecord::Migration[4.2]

  def change
    add_column :rewards, :reward_type, :string
  end

end
