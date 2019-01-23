
class ChangeDiscountColumnName < ActiveRecord::Migration[4.2]

  def change
    rename_column :rewards, :discount, :reward_description
  end

end
