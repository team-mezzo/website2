class RemoveLoginableFromStakeholders < ActiveRecord::Migration
  def change
  	remove_column :stakeholders, :loginable_id
  	remove_column :stakeholders, :loginable_type
  end
end
