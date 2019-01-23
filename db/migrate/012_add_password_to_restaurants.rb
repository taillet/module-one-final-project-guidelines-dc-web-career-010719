
class AddPasswordToRestaurants < ActiveRecord::Migration[4.2]

  def change
    add_column :restaurants, :password, :string
  end

end
