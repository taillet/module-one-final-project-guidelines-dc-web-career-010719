
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
