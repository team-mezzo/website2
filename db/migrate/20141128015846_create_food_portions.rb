class CreateFoodPortions < ActiveRecord::Migration
  def change
    create_table :food_portions do |t|
      t.integer :raw_amount
      t.integer :processed_amount
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
