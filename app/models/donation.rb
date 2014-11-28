class Donation < ActiveRecord::Base
	has_one :food_portion

	def to_json
		portion = self.food_portion

		{ :id => self.id,
		  :pickup_start => self.pickup_start,
		  :pickup_end => self.pickup_end, 
		  :status => self.status,
		  :raw_amount => portion.raw_amount,
		  :processed_amount => portion.processed_amount,
		  :description => portion.description,
		  :image_url => portion.image_url }
	end
end
