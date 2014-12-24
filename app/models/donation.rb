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

	def to_json
		portion = self.food_portion

		{ :id => self.id,
		  :pickup_start => self.pickup_start,
		  :pickup_end => self.pickup_end, 
		  :status => self.status,
		  :food_portion => portion } 
		  # :raw_amount => portion.raw_amount,
		  # :processed_amount => portion.processed_amount }
		  # :description => portion.description,
		  # :image_url => portion.image_url }
	end

	def donor_name
		Stakeholder.find_by(id: self.donor_id).business_name
	end

	def recipient_name
		Stakeholder.find_by(id: self.recipient_id).business_name
	end
end
