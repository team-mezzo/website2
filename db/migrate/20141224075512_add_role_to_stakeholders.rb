class AddRoleToStakeholders < ActiveRecord::Migration
  def change
  	add_column :stakeholders, :role, :string
  end
end
