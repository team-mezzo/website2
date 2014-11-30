class Stakeholder < ActiveRecord::Base
	# CALLBACKS
	before_save { self.email = email.downcase }

	# ASSOCIATIONS
	belongs_to :loginable, polymorphic: true

	# VALIDATIONS
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
					  length: { maximum: 255 },
					  uniqueness: { case_sensitive: false }, # caps or not
					  format: { with: EMAIL_REGEX }
    has_secure_password
    validates :password, length: { minimum: 6 }
end
