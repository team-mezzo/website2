class ChangeStatusInFoodPortions < ActiveRecord::Migration
  def change
  	change_column :donations, :status, :integer
  end
end
