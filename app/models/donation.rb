include Statuses

class Donation < ActiveRecord::Base
	attr_accessor :status_object

	# FOOD PORTION
	has_one :food_portion, dependent: :destroy
	accepts_nested_attributes_for :food_portion

	# STAKEHOLDERS
	belongs_to :donor, :class_name => 'Stakeholder', :foreign_key => 'donor_id'
	belongs_to :recipient, :class_name => 'Stakeholder', :foreign_key => 'recipient_id'

	# VALIDATIONS
	validates :donor_id, presence: true
	validates :recipient_id, presence: true
	validates :pickup_start, presence: true, is_future_datetime: true
	validates :pickup_end, presence: true, is_future_datetime: true
	validate :is_valid_datetime_window
	validates :status, numericality: { only_integer: true,
									   greater_than_or_equal_to: 0,
									   less_than_or_equal_to: 4 },
					   presence: true

	# ============================================================================
	# ================================== JSON ====================================
	# ============================================================================
	def as_json(options = nil)
		{ :id => self.id,
		  :pickup_start => self.pickup_start,
		  :pickup_end => self.pickup_end, 
		  :status => self.status_string.camelize(:lower), # camelcase version of status string
		  :food_portion => self.food_portion,
		  :donor_id => self.donor_id,
		  :recipient_id => self.recipient_id }
	end

	# ============================================================================
	# =========================== DONOR AND RECIPIENT ============================
	# ============================================================================
	def donor_name
		Stakeholder.find_by(id: self.donor_id).business_name
	end

	def recipient_name
		Stakeholder.find_by(id: self.recipient_id).business_name
	end

	# ============================================================================
	# ================================= STATUS ===================================
	# ============================================================================
	def update_status
		@status_object = Status.init(self.status) # make approriate object from current int
		@status_object.update(self)
		self.save
	end

	def status_string
		Status.status_strings[self.status]
	end

	def accepted?
		return self.status == Statuses::ACCEPTED
	end

	# ============================================================================
	# ============================== VALIDATIONS =================================
	# ============================================================================
	# ensures that pickup time window is valid (end is after or equal to start)
	def is_valid_datetime_window
		if (pickup_start && pickup_end) && (pickup_start > pickup_end)
			errors.add(:pickup_end, "must be later than pickup start")
		end
	end
end
