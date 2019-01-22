
class CreateCustomerTable < ActiveRecord::Migration[4.2]

  def change
    create_table :customers do |t|
      t.string :name
    end
  end

end
