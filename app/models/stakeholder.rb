class Stakeholder < ActiveRecord::Base
	# ACCESSIBLE ATTRIBUTES
	attr_accessor :remember_token

	# CALLBACKS
	before_save { self.email = email.downcase }

	# ASSOCIATIONS
	has_many :donations
	has_many :donors, :through => :donations
	has_many :recipient, :through => :donations

	# VALIDATIONS
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
					  length: { maximum: 255 },
					  uniqueness: { case_sensitive: false }, # caps or not
					  format: { with: EMAIL_REGEX }
	has_secure_password
	validates :password, length: { minimum: 6 }
	validates :role, presence: true
	validates :business_name, presence: true

	# ============================================================================
	# ================================== ROLE ====================================
	# ============================================================================
	def isDonor?
		self.role == 'donor'
	end

	def isRecipient?
		self.role == 'recipient'
	end

	# returns all recipients in Stakeholder class
	def Stakeholder.recipients
		Stakeholder.select { |user| user.isRecipient? }
	end

	# ============================================================================
	# ============================== AUTHENTICATION ==============================
	# ============================================================================

	# Returns the hash digest of the given string.
	def Stakeholder.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token for remember me.
	def Stakeholder.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = Stakeholder.new_token;
		update_attribute(:remember_digest, Stakeholder.digest(remember_token));
	end

	# Forgets user (undoes remember)
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil? # prevent confusion if logged out in another browser
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
end
