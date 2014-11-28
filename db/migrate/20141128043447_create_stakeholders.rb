class CreateStakeholders < ActiveRecord::Migration
  def change
    create_table :stakeholders do |t|
      t.string :business_name
      t.string :manager_name
      t.string :email

      t.references :loginable, polymorphic: true
      t.timestamps
    end
  end
end
