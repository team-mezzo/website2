class ChangeStatusDefaultInDonations < ActiveRecord::Migration
  def change
  	change_column :donations, :status, :integer, :default => 0
  end
end
