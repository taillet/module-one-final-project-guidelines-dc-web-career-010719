
class ChangeRewardsRequirementDatatypeToReal < ActiveRecord::Migration[4.2]

  def change
    change_column :rewards, :requirement, :real
  end

end
