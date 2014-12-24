class DropDonorAndRecipientTables < ActiveRecord::Migration
  def change
  	drop_table :donors
  	drop_table :recipients
  end
end
