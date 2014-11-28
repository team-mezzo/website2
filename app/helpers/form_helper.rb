module FormHelper
	# setups up donation with food portion for new/edit form
	def setup_donation(donation)
		# makes new food portion for donation if doesn't already exist
		donation.food_portion ||= FoodPortion.new 
		donation
	end
end