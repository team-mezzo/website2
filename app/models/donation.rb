class Donation < ActiveRecord::Base
	# FOOD PORTION
	has_one :food_portion, dependent: :destroy
	accepts_nested_attributes_for :food_portion

	# STAKEHOLDERS
	belongs_to :donor, :class_name => 'Stakeholder', :foreign_key => 'donor_id'
	belongs_to :recipient, :class_name => 'Stakeholder', :foreign_key => 'recipient_id'

	# VALIDATIONS
	validates :donor_id, presence: true
	validates :recipient_id, presence: true
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
	def Donation.possible_statuses
		["unitiated", "donation accepted", "driver left", "driver arrived", "donation complete"]
	end

	def status_string
		Donation.possible_statuses[self.status]
	end
end
