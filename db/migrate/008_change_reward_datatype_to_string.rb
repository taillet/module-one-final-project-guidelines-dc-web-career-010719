
class ChangeRewardDatatypeToString < ActiveRecord::Migration[4.2]

  def change
    change_column :rewards, :reward_description, :string
  end

end
