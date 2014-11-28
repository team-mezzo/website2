class Recipient < ActiveRecord::Base
	has_many :stakeholders, as: :loginable
end
