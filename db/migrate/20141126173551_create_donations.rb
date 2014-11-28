class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.datetime :pickup_start
      t.datetime :pickup_end
      t.string :status

      t.timestamps
    end
  end
end
