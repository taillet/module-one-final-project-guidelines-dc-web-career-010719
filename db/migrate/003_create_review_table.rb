
class CreateReviewTable < ActiveRecord::Migration[4.2]

  def change
    create_table :reviews do |t|
      t.integer :customer_id
      t.integer :restaurant_id
      t.integer :etiquette
      t.integer :punctuality
      t.integer :tipping
      t.integer :overall
    end
  end

end
