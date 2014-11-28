class RemoveFoodPortionIdFromDonations < ActiveRecord::Migration
  def change
  	remove_column :donations, :food_portion_id
  	add_column :food_portions, :donation_id, :integer
  end
end
