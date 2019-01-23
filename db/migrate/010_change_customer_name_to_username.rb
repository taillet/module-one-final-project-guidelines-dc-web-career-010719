
class ChangeCustomerNameToUsername < ActiveRecord::Migration[4.2]

  def change
    rename_column :customers, :name, :username
  end

end
