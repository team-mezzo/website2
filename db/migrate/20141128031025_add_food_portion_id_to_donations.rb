class AddFoodPortionIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :food_portion_id, :integer
  end
end
