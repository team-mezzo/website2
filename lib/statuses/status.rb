include Statuses

class Status
	include ActiveModel::Model

	@@status_strings = ["uninitiated", "donation accepted", "driver left", "driver arrived", "donation complete"]

	def self.status_strings
		@@status_strings
	end

	def self.init(status_num)
		case status_num
		when Statuses::UNINITIATED
			return Uninitiated.new
		when Statuses::ACCEPTED
			return Accepted.new
		when Statuses::DRIVER_LEFT
			return DriverLeft.new
		when Statuses::DRIVER_ARRIVED
			return DriverArrived.new
		when Statuses::COMPLETE
			return Complete.new
		else
			return Uninitiated.new
		end
	end
end