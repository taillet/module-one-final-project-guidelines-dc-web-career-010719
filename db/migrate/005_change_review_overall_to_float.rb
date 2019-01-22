
class ChangeReviewOverallToFloat < ActiveRecord::Migration[4.2]

  def change
    change_column :reviews, :overall, :real
  end

end
