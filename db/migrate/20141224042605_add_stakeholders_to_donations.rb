class AddStakeholdersToDonations < ActiveRecord::Migration
  def change
  	add_column :donations, :donor_id, :integer
  	add_column :donations, :recipient_id, :integer
  end
end
