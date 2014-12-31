include Statuses

class Uninitiated < Status
	def update(donation)
		if donation.status == Statuses::UNINITIATED && (Time.now < donation.pickup_end)
			donation.status = Statuses::ACCEPTED
		end
	end
end